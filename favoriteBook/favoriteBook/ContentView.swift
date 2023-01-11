//
//  ContentView.swift
//  favoriteBook
//
//  Created by Emincan on 10.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        NavigationView {
            
            
            
            VStack {
                List{
                    ForEach(myFavs) { fav in
                        Section(header: Text(fav.title)) {
                            ForEach(fav.elements){ element in
                                NavigationLink(destination: DetailsView(choosenFav: element)) {
                                    Text(element.name)
                                }
                                
                            }
                        }
                    }
                }.navigationTitle(Text("My Favorites"))
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
