import 'head.dart';
import 'header.dart';
import 'footer.dart';

index(data) {
  return '''
    <!DOCTYPE html>
    <html>
      ${head()}
      <body>
        ${header()}
        <div class="container">
          <main>
            <h1>Welcome!</h1>
            <p>
            I’m Khaled (pronounced خالد). I like to solve hard problems, whether programming, mathematics, 
            overly complex cooking, unreasonably hard video games, or teaching myself to touch type in a new layout.
            I write about that process of going from having no clue what I’m doing to being competant. 
            Sometimes, I even get good at stuff.
            </p>

            <h4>What’s here</h4>
            <ul>
            <li>Blog: New writings and ideas</li>
            <li>Projects: Ongoing stuff I’m working on and iterating on</li>
            <li>Archive: Old writings and ideas</li>
            <li>Daybook: Scratch notes that aren’t yet associated with a project</li>
            </ul>
            <p
            I used to write with the justification that sharing my stories, experiences, and opinions might 
            be helpful to other people. In retrospect, that seems really presumptous. 
            But writing and publishing my ideas did help me clarify them, so now that’s why I write.
            </p>

            <p>
            Regarding my older writings and opinions: I am in the process of removing a lot of the old posts 
            that I now find offensive, irrelevant, or unfounded. People can change, and people can change 
            their minds. Maybe I’ll write a post on that one day.
            </p>
          </main>
          <div class="column sidebar">
            <div class="post-list">
              <ul>
                ${data['postList']}
              </ul>
            </div>
          </div>
        </div>
        ${footer()}
      </body>
    </html>
    ''';
}
