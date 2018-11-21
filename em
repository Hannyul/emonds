/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package emonds_algorithm;

import java.util.*;

/**
 *
 * @author Lenovo
 */
public class Emonds_algorithm {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
     int[][] Graph = {
            
            {0, 3, 0, 3, 0, 0, 0},
            {0, 0, 4, 0, 0, 0, 0},
            {3, 0, 0, 1, 2, 0, 0},
            {0, 0, 0, 0, 2, 6, 0},
            {0, 1, 0, 0, 0, 0, 1},
            {0, 0, 0, 0, 0, 0, 9},
            {0, 0, 0, 0, 0, 0, 0}
        
        };
     
        int src = 0;
        int sink = 6;
        ArrayList AugPaths = new ArrayList();
        int max = EM(Graph, src, sink,AugPaths);
        System.out.println("poaths");
        for (int i = 0; i < AugPaths.size(); i++) {
            System.out.print(AugPaths.get(i) );
            if ((int)AugPaths.get(i) == 6) {
                System.out.println("");
            }
            else{
                System.out.print("->");
            }
       //     System.out.println("");
        }
        System.out.println("");
        System.out.println("max flow " + max);
        
    } // main 
    
    public static boolean BFS(int graph[][], int src, int sink, int parent[],ArrayList<Integer> AugPaths) 
    { 
        boolean visited[] = new boolean[graph.length]; 
       
         
        for(int i=0; i<graph.length; ++i){
            visited[i]=false; 
        }
  
        // Create a queue, enqueue source vertex and mark 
        // source vertex as visited 
        Queue<Integer> queue = new LinkedList<Integer>(); 
        queue.add(src); 
        visited[src] = true; 
        parent[src]=-1; 
  
        // Standard BFS Loop 
        while (queue.size()!=0) 
        { 
            int u = queue.poll(); 
  
            
            for (int v=0; v<graph.length; v++) 
            { 
                if (visited[v]==false && graph[u][v] > 0) 
                { 
                   //  AugPaths.add(v);
                    queue.add(v); 
                    parent[v] = u; 
                    visited[v] = true; 
                } 
            }
            
        } 
      //  AugPaths.add(src);
  
        //Collections.reverse(AugPaths);
       // AugPaths.add(AugPaths);
//         for (int i = 0; i < AugPaths.size(); i++) {
//            //System.out.print("Path " + i + ": ");
//           
//            System.out.print(AugPaths.get(i)+ " ");
//           // System.out.println("");
//        }
//        if (visited[sink] !=src)
//        System.out.println("");
       
        return (visited[sink] == true); 
    } 
  
    // Returns tne maximum flow from s to t in the given graph 
    public static int EM(int graph[][], int s, int t,ArrayList<Integer> AugPaths) 
    { 
        int u, v; 
  
        // Create a residual graph and fill the residual graph 
        // with given capacities in the original graph as 
        // residual capacities in residual graph 
  
        // Residual graph where rGraph[i][j] indicates 
        // residual capacity of edge from i to j (if there 
        // is an edge. If rGraph[i][j] is 0, then there is 
        // not) 
        int rGraph[][] = new int[graph.length][graph.length]; 
  
        for (u = 0; u < graph.length; u++) 
            for (v = 0; v < graph.length; v++) 
                rGraph[u][v] = graph[u][v]; 
  
        // This array is filled by BFS and to store path 
        int parent[] = new int[graph.length]; 
  
        int max_flow = 0;  // There is no flow initially 
  
       
        while (BFS(rGraph, s, t, parent,AugPaths)){ 
             
            int path_flow = 999; 
            
            for (v=t; v!=s; v=parent[v]) 
            { 
                //System.out.println(v);
                AugPaths.add(v);
                u = parent[v]; 
                path_flow = Math.min(path_flow, rGraph[u][v]); 
            }
                
   
            // update residual capacities of the edges and 
            // reverse edges along the path 
            for (v=t; v != s; v=parent[v]) 
            { 
               
                u = parent[v]; 
                rGraph[u][v] -= path_flow; 
                rGraph[v][u] += path_flow; 
              
            } 
  
            // Add path flow to overall flow 
            max_flow += path_flow; 
//             AugPaths.add(s);
//      Collections.reverse(AugPaths);
             
        } 
  
        AugPaths.add(s);
      Collections.reverse(AugPaths);

      
        return max_flow; 
    } 
    
    
    
}// class
