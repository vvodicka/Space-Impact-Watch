//
//  LeaderBoardView.swift
//  Space Impact iOS
//
//  Created by Vladislav Vodicka on 18/05/2021.
//

import SwiftUI
import GameKit

struct LeaderBoardView: View {
    
    @State var loaded = false
    @State var error: String?
    
    @State var board: GKLeaderboard?
    @State var localPlayerScore: GKLeaderboard.Entry?
    @State var topScores: [GKLeaderboard.Entry]?
    
    private let connectivityProvider = ConnectivityProvider()
    
    func loadLeaderBoard() {
        self.loaded = false
        self.error = nil
        
        if nil == board {
            GKLeaderboard.loadLeaderboards(IDs: ["space_impact_leaderboard"]) {(boards, error) in
                if error != nil {
                    self.error = error?.localizedDescription
                    self.loaded = true
                } else {
                    self.board = boards?.first
                    self.updateScores()
                }
            }
        } else {
            self.updateScores()
        }
    }
    
    func authenticate() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            if error != nil {
                self.loaded = true
                self.error = error?.localizedDescription
            } else {
                loadLeaderBoard()
            }
        }
    }
    
    func updateScores() {
        let localTopScore = connectivityProvider.getScore()
        print(localTopScore)
        
        board?.submitScore(localTopScore ?? 0, context: 0, player: GKLocalPlayer.local, completionHandler: {(error) in
            if error != nil {
                self.error = error?.localizedDescription
                self.loaded = true
            } else {
                board?.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 100),
                                   completionHandler: {(local, entries, count, error) in
                                    self.localPlayerScore = local
                                    self.topScores = entries
                                    self.loaded = true
                                    if error != nil {
                                        self.error = error?.localizedDescription
                                    }
                                   })
            }
        })
        
    }
    
    var body: some View {
        ZStack{
            Color("Licorice").ignoresSafeArea()
            VStack{
                Text("Leaderboard").multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 25))
                
                if loaded {
                    if error != nil {
                        VStack {
                            Spacer()
                            Text(error!).multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 25))
                            Spacer()
                        }
                    } else {
                        if localPlayerScore != nil {
                            Text("Your TOP score: \(localPlayerScore?.formattedScore ?? "0")").multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 20))
                                .padding()
                        }
                        
                        if let topScores = self.topScores {
                            Text("Top 100").multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 25)).padding()
                            
                            ScrollView {
                                VStack {
                                    ForEach(topScores, id: \.player.gamePlayerID) { result in
                                        HStack {
                                            Text("\(result.player.alias)")
                                                .frame(width: 200, height: 25, alignment: .leading)
                                                .truncationMode(.tail)
                                                .multilineTextAlignment(.leading).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 15)).padding()
                                            Spacer()
                                            Text("\(result.formattedScore)").bold()
                                                .multilineTextAlignment(.trailing).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 20)).padding()
                                        }
                                    }
                                }
                            }
                        } else {
                            Text("Leaderboard is empty").multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 25)).padding()
                        }
                        
                        Button(action: {
                            if !GKLocalPlayer.local.isAuthenticated {
                                authenticate()
                            } else {
                                loadLeaderBoard()
                            }
                        }, label: {
                            Text("Reload").multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 20)).padding(8).border(Color("Green"), width: 5)
                            
                        }).padding()
                    }
                } else {
                    VStack {
                        Spacer()
                        ImageAnimated(imageSize: CGSize(width: 50, height: 25),
                                      imageNames: ["comet1","comet2"])
                            .frame(width: 50, height: 25, alignment: .center)
                        
                        Text("Loading...").multilineTextAlignment(.center).foregroundColor(Color("Green")).font(.custom("Nokia Cellphone FC", size: 25))
                        Spacer()
                    }
                }
            }.padding(.top)
        }.onAppear {
            if !GKLocalPlayer.local.isAuthenticated {
                authenticate()
            } else {
                loadLeaderBoard()
            }
        }
    }
}

struct ImageAnimated: UIViewRepresentable {
    let imageSize: CGSize
    let imageNames: [String]
    let duration: Double = 0.3
    
    func makeUIView(context: Self.Context) -> UIView {
        let containerView = UIView(frame: CGRect(x: 0, y: 0
                                                 , width: imageSize.width, height: imageSize.height))
        
        let animationImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        
        animationImageView.clipsToBounds = true
        animationImageView.layer.cornerRadius = 5
        animationImageView.autoresizesSubviews = true
        animationImageView.contentMode = UIView.ContentMode.scaleAspectFill
        animationImageView.tintColor = UIColor(named: "Green")
        
        var images = [UIImage]()
        imageNames.forEach { imageName in
            if let img = UIImage(named: imageName) {
                images.append(img)
            }
        }
        
        animationImageView.image = UIImage.animatedImage(with: images, duration: duration)
        
        containerView.addSubview(animationImageView)
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ImageAnimated>) {
        
    }
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
    }
}
