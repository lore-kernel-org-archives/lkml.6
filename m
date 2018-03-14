Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933026AbeCNA4a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:56:30 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:40892 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932732AbeCNA43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:56:29 -0400
X-Google-Smtp-Source: AG47ELta3h+74Z1tXKsFMCdpt8Gm7ldBZ/kyCIlEtjYXXLOF+poEOT//g0x2DW99J1g56LI9kOs3Ki1GWfk2oS6+tmA=
MIME-Version: 1.0
In-Reply-To: <CANiq72k=sw=Cxoes9tCNnVp0LweXRN5U+RuXU56QvO__HHQ1ZA@mail.gmail.com>
References: <20180312233952.niz2cuz7psv4fe2s@gmail.com> <20180313140037.7717460162192c99775b135e@linux-foundation.org>
 <CANiq72nKXXV7SDTmCwvizWA3ubdczNZV8qT2-PoGAQnDfX9qtg@mail.gmail.com>
 <1520980163.2049.54.camel@perches.com> <CANiq72k=sw=Cxoes9tCNnVp0LweXRN5U+RuXU56QvO__HHQ1ZA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Mar 2018 01:56:08 +0100
Message-ID: <CANiq72=UXiK1mocAPaYz4uoBU=EMJoUMArdmdKiEr6Q=zs76MA@mail.gmail.com>
Subject: Re: [PATCH] clang-format: add configuration file
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Robo Bot <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 1:18 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Since we seem to agree on having this, I will send a v2 after I try a
> few experiments to try to reduce more the produced diffs, explain
> things better in Documentation/, add more comments in the config file
> and send a v2.

Alright, time for a fun fact: roughly 11 hours after I sent the first
message, Microsoft announces they are going to support clang-format in
Visual Studio 15.7:

  https://blogs.msdn.microsoft.com/vcblog/2018/03/13/clangformat-support-in-visual-studio-2017-15-7-preview-1/

Talk about coincidences... :-)

On related news, Google also announced that they are compiling Chrome
with clang on Windows a week or so ago...

Cheers,
Miguel

[*] Their timestamp: <time class="entry-date published"
datetime="2018-03-13T11:13:51+00:00">March 13, 2018</time>
