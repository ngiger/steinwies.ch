# Lookandfeel -- steinwies.ch -- 19.11.2002 -- benfay@ywesee.com

require 'sbsm/lookandfeel'

module Steinwies
  class Lookandfeel < SBSM::Lookandfeel
    LANGUAGES = ['en']
    TXT_RESOURCES = File.expand_path("../../doc/resources", File.dirname(__FILE__))
    DICTIONARIES  = {
      'de'  =>  {
        # a
        :adresse => 'Adresse',
        :anrede  => 'Anrede',
        :anzahl  => 'Anzahl',
        # b
        :back           => 'Zurück',
        :bestell_diss   => 'Dissertation, \'Ein Leben für Kinder\'',
        :bestell_pedi   => 'Pädiatrie und Grenzgebiete',
        :buch_bestellen => 'Bücher bestellen',
        # c
        :confirm     => 'Weiter',
        :confirmtext => 'Bitte Überprüfen Sie ihre Angaben.',
        # d
        :deprivation  => 'Deprivation<br>(PDF, 3 Mb)',
        :diss_pdf     => 'Dissertation Teil1<br>(Pdf, 825 Kb)',
        :diss2_pdf    => 'Dissertation Teil2<br>(Pdf, 994 Kb)',
        :dissertation => 'Dissertation',
        :disstext     => 'Die Vorliegende Arbeit wurde von der Philosophischen Fakultät der Universität Zürich im Wintersemester 1999/2000 auf Antrag von Prof. Dr. med. Heinz Stefan Herzka als Dissertation angenommen.',
        :disstitel    => 'Ein Leben für Kinder',
        :divider      => '&nbsp;|&nbsp;',
        :download     => 'Downloads:',
        # e
        :email           => 'Ihre E-Mail Adresse',
        :erfahrung_title => 'Berufliche Erfahrungen',
        :error_message   => 'Ihre E-Mail Adresse wird benötigt',
        # f
        :familie_title   => 'Familie',
        :favoritemail_ti => 'Voted Women\'s Favorite Email of the Year',
        :feedbacktext    => 'Bitte schreiben Sie hier Ihren Feedbacktext:',
        :firma           => 'Firma',
        :flyer           => 'Flyer<br>(Pdf, 46 Kb)',
        # h
        :home          => 'Home',
        :html_title    => 'Praxis Steinwies',
        :kontakt       => 'Kontakt',
        :kontakt_title => 'Kontakt',
        # l
        :lageplan    => 'Lageplan',
        :link1       => '',
        :link2       => '',
        :link3       => '',
        :link_title  => 'Links',
        :links       => 'Links',
        :logo        => 'Praxis Steinwies',
        # m
        :meierhofer => 'Marie Meierhofer',
        # n
        :name       => 'Name',
        # o
        :ort => 'Ort',
        # p
        :person          => 'Zur Person',
        :person_title    => 'Zu meiner Person',
        :person_text     => 'Ich bin 1947 im Kanton Schaffhausen geboren und aufgewachsen. Seit vielen Jahren arbeite ich in Zürich und bin Mutter von drei erwachsenen "Kindern". Ich lebe in Zürich. In meiner Freizeit hüte ich ein Enkelkind und mache Yoga.',
        :planbeschreibun => 'Tram Nr. 3 und 8 bis Haltestelle Hottingerplatz<br>Tram Nr. 9 und 5 bis Haltestelle Kunsthaus/Pfauen<br>S3, S5, S6, S7, S9, S12, S16, S18 bis Bahnhof Stadelhofen,<br>05 Gehminuten vom Hottingerplatz,<br>10 Gehminuten vom Kunsthaus,<br>15 Gehminuten vom Stadelhofen.',
        :planimage       => 'Lageplan',
        :plantitle       => 'Wie Sie uns finden:',
        :portrait        => 'Maja Wyss-Wanner',
        :praxisschild    => 'Psychiatrisch - psychotherapeutische<br>Praxisgemeinschaft Steinwies<br>Steinwiesstr. 37, 8032 Zürich',
        :praxistelnu     => '01 261 65 34 Tel G<br>01 261 65 89 Tel P<br>079 255 49 88 mobil<br>01 261 65 14 Fax P',
        # r
        :reset => 'Zurücksetzen',
        # s
        :schildmail1         => 'thea.altherr&#64;bluewin.ch',
        :schildmail2         => 'Praxis.gut&#64;hin.ch',
        :schildmail3         => 'daniel.marti&#64;kispi.uzh.ch',
        :schildmail4         => 'barbara.menn&#64;bluewin.ch',
        :schildmail5         => 'mmpopper&#64;hotmail.com',
        :schildmail6         => 'maja.wyss&#64;steinwies.ch',
        :schildpers1         => 'Thea Altherr, dipl.  psych.',
        :schildpers2         => 'Mario Gut, Dr. med.',
        :schildpers3         => 'Daniel Marti, Dr. med.',
        :schildpers4         => 'Barbara Menn, lic. phil.',
        :schildpers5         => 'M. Miriam Popper, lic. phil.',
        :schildpers6         => 'Maja Wyss-Wanner, Dr. phil.',
        :schildtel1          => 'Tel 044 362 99 72, ',
        :schildtel2          => 'Tel 044 261 80 00, ',
        :schildtel3          => 'Tel 044 266 73 21 (Kispi), ',
        :schildtel4          => 'Tel 079 605 76 04, ',
        :schildtel5          => 'Tel 044 251 85 58, ',
        :schildtel6          => 'Tel 044 261 65 34, ',
        :schildtitel1        => 'Fachpsychologin für Psychotherapie FSP',
        :schildtitel2        => 'Facharzt für Psychiatrie &amp; Psychotherapie FM',
        :schildtitel3        => 'Facharzt für Kinder- und Jugendpsychiatrie &amp; Psychotherapie FMH',
        :schildtitel4        => 'Fachpsychologin für Psychotherapie FSP',
        :schildtitel5        => 'Fachpsychologin für Psychotherapie FSP',
        :schildtitel6        => 'Fachpsychologin für Psychotherapie &amp; Kinder und Jugendliche FSP',
        :schildpers_main     => 'Dr. phil. Maja Wyss-Wanner',
        :schildpers_main2    => 'Psychotherapeutin FSP',
        :schildpers_main3    => 'Kinder- und Jugendpsychologin FSP',
        :schildpers_main4    => 'Hypnotherapeutin ghyps',
        :schmunzeln          => 'Zum Schmunzeln',
        :schmunzelnte        =>  txt_file('schmunzeln_text.txt').call,
        :schwerpunkte        => 'Schwerpunkte',
        :schwerpunkte_list1  => 'Beratung für Kinder und ihre Eltern bei Sorgen bezüglich Lernen und/oder Verhalten zu Hause und in der Schule.',
        :schwerpunkte_list2  => 'Krisenintervention, wenn Ihr Baby unaufhörlich schreit, die Nahrung verweigert oder Sie sonst zur Verzweiflung bringt.',
        :schwerpunkte_list3  => 'Psychotherapeutische Begleitungen für Kinder, Jugendliche und Erwachsene bei Stolpersteinen in Familie, Schule und/oder Beruf.',
        :schwerpunkte_list4  => 'Coaching zur Bewältigung von Prüfungen in Schule und Beruf für Jugendliche und Erwachsene.',
        :schwerpunkte_list5  => 'Lerntherapie für Kinder und Jugendliche, die den Glauben an ihre Fähigkeiten wieder finden wollen.',
        :schwerpunkte_list6  => 'Krisenberatung, wenn das Leben Purzelbäume für Sie bereit hält.',
        :schwerpunkte_list7  => 'Körperbezogene Psychotherapie, wenn Sie ernsthaft erkrankt sind.',
        :schwerpunkte_list8  => 'Begleitung in Leid und Trauer, wenn Sie oder eine Ihnen nahe stehende Person krank sind.',
        :schwerpunkte_list9  => 'Yoga und Yogatherapie.',
        :schwerpunkte_text2  => txt_file('werkzeuge.txt').call,
        :schwerpunkte_text3  => txt_file('finanzierung.txt').call,
        :schwerpunkte_title1 => 'Schwerpunkte meiner Arbeit',
        :schwerpunkte_title2 => 'Berufliche Werkzeuge',
        :schwerpunkte_title3 => 'Zur Finanzierung von Beratungen und Therapien',
        :sendmail            => 'Mail senden',
        :senttext            => 'Vielen Dank!<br>Ihre Nachricht wurde erfolgreich gesendet.',
        :submit              => 'Senden',
        # t
        :telefon => 'Telefon',
        :text    => 'Text',
        # v
        :vorname => 'Vorname',
        # w
        :werdegang_date1  => '1969',
        :werdegang_date11 => '1999-2002',
        :werdegang_date12 => 'Seit 1996',
        :werdegang_date2  => '1989-1996',
        :werdegang_date3  => '1985-1995',
        :werdegang_date4  => '1995-2002',
        :werdegang_date5  => '2000',
        :werdegang_date6  => '2000-2005',
        :werdegang_date7  => '2006',
        :werdegang_date8  => '1993',
        :werdegang_date9  => '1996-1998',
        :werdegang_date10 => '1997-1998',
        :werdegang_text1  => 'Primarlehrerin in Schaffhausen',
        :werdegang_text11 => 'Schulpsychologischer Dienst Birmensdorf, Uitikon, Aesch. Diagnostik, Beratung und Begleitungen von Kindern und Jugendlichen sowie ihren Eltern und Lehrpersonen.',
        :werdegang_text12 => 'Praxisgemeinschaft Steinwies. Diagnostik, Beratung und Psychotherapie für Kinder, Jugendliche und ihre Familien sowie für Erwachsene.',
        :werdegang_text2  => 'Studium der Psychologie, Psychopathologie und Neuro-psychologie an der Universität Zürich.',
        :werdegang_text3  => 'Ausbildung in Individualpsychologischer Psychotherapie bei Viktor Louis und in Psychodrama bei Dag Blomkvist.',
        :werdegang_text4  => 'Weiterbildung in Hypnotherapie bei Susy Signer und der Schweizerischen Gesellschaft für Klinische Hypnose ghyps.',
        :werdegang_text5  => 'Doktorat zum Lebenswerk der Kinderpsychiaterin und Institutsgründerin Marie Meierhofer bei Prof. Heinz Stefan Herzka an der Universität Zürich.',
        :werdegang_text6  => 'Weiterbildung in systemischer Psychotherapie am Institut für Systemische Entwicklung und Fortbildung IEF, Zürich.',
        :werdegang_text7  => 'Praxisbewilligung Kanton Zürich.',
        :werdegang_text8  => 'Kinder- und Jugendpsychiatrischer Dienst der Stadt Zürich. Diagnostik und Begleitungen von Kindern.',
        :werdegang_text9  => 'Sozialamt der Stadt Opfikon. Begleitung von Erwerbslosen.',
        :werdegang_text10 => 'Landheim Brütisellen. Beratung von Jugendlichen.',
        :werdegang_title  => 'Beruflicher Werdegang',
      }
    }

    HTML_ATTRIBUTES = {
      :back =>  {
        'class'   => 'button',
        'onclick' => 'location.href=\'/de/back\''
        },
      :bestell_diss => {
        'class' => 'anzahl',
      },
      :bestell_pedi => {
        'class' => 'anzahl',
      },
      :reset =>  {
        'class' => 'button',
        'type'  => 'reset',
      },
      :submit => {
        'class' => 'button',
      },
      :text => {
        'wrap' => 'hard',
        'cols' => '72',
        'rows' => '20',
      },
      :flyer => {
        'href'   => '/resources/pdf/3FlyerMM.pdf',
        'target' => '_blank',
      },
      :diss_pdf => {
        'href'   => '/resources/pdf/Dissertation_Teil_1_14.08.00_aktualisiert_10.2.2009.pdf',
        'target' => '_blank',
      },
      :diss2_pdf => {
        'href'   => '/resources/pdf/chart_von_m_meierhofer.pdf',
        'target' => '_blank',
      },
      :deprivation => {
        'href'   => '/resources/pdf/4MM_Deprivation.pdf',
        'target' => '_blank',
      },
    }

    RESOURCES = {
      :css        => 'steinwies.css',
      :portrait   => 'Maja_Wyss.jpg',
      :planimage  => 'plan.jpg',
      :titelseite => 'titelseite_diss.jpg',
      :meierhofer => 'm_meierhofer.jpg',
    }

    def initialize(session=Session.new)
      super
    end

    def resource(rname, rstr=nil)
      collect_resource([self::class::RESOURCE_BASE], rname, rstr)
    end

    def base_url
      [
        @session.http_protocol + ':/',
        @session.server_name,
        @language,
        # pseudo zone
        @session.zone
      ].compact.join('/')
    end

    def event_url(_=nil, event=:home, args={})
      args = Array(args).collect { |*pair| pair }.flatten
      [base_url, event, args].compact.join('/')
    end
  end
end
