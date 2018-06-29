Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2002C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674AB24AC1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674AB24AC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933904AbeF2GmR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:42:17 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42009 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbeF2GmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:42:16 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MSrrB-1fgB6B0Fbp-00Rojy; Fri, 29 Jun 2018 08:41:50 +0200
Date:   Fri, 29 Jun 2018 08:41:48 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     pavel@ucw.cz, jacek.anaszewski@gmail.com, ben.whitten@gmail.com,
        geert+renesas@glider.be, w@1wt.eu, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-morse: send out morse code
Message-ID: <20180629064147.GA3219@arbeit>
References: <20180628134227.GA1719@arbeit>
 <20180628185630.GA6095@amd>
 <20180628202955.GA1534@imap.1und1.de>
 <20180628204516.GA29146@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628204516.GA29146@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:BESya8HXIGTiZxjvEtRgMWjehImZBASg3QT0dRhxjxcfWet6nQZ
 BTV6aaT0ZoA7ey6CH+NtonIIojk6yhbTlBvIEcl7/jARWhZQLJoZ3h4j8U/nrQ7bLUdgODA
 ibPbkKPBo3HvWzVnSa/lGnNRdafMRAZBfphcfQ2lsZww/jOahGW7mN/d4rWin7diZ+cTvUZ
 lI0TGjkcW686HDjMXIrcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AZC+aXXXUg4=:cff+WXPVVaQE/2TsWy0woc
 sUioTMSkXpfPOPLbhRxQJvg4JhHQVrcDO34t3Jg7qGHKRfx2ySNU7US6X3HC0b7ft3gSiI7gW
 kYSyfC5vvKTPiQBQtAeu/BCFTA2twKf1L3YXeNsEaOQBwstAmoz2arov7csq3SBrcGBMLu2f9
 dSHfRmdiFxNeoOL6kkhc2ZHuvXTG6RI+zwVBYhb1L5xC4/O+UxPoOicSotxByLDaFU0kB2AvP
 sEbH8j/xA17nUuNhxxqss/Rcv+7ogBZljH05Ba1k9/GXvAjnmWG82yALbtAbo3DUwQ3Brg6Of
 B3NbskNoCmybiJHaf8LwFFlUaPsWlAQQApRJqzMK5objVnt0oaaBUTXw9CiJPaEiIzgWyt+v+
 QH7yl5g+dVynBC2uUnPBY7t88Cqt5qsTm5mOUgAsPJFejzhSgl40uXuZXn9tOhAbo0jYlNg1l
 rrXrOutJOkTeBrVM1W8dMrjNwYmg1vZIYGk4aSvL09kv7Ilw8G6PfWiWaaIVuIhEpMANRFasM
 bUT6zCZ8nXXNcISvi8vbSzkGIFbsPdry+DJ6BpTa+erewJBdMfBI6UJRRCS2MtINZVauM2ExY
 rOFJvXfSzfNSdBMpAyqwK3l18J6nzxgZOMl3RNuKYQavp8D0ALW+zSEJ5tZ8+SmOUmOQliZ0+
 y/UQXaFFL8DF98mQesHL5Y+x1vmS7OCwzA8t9aYPkR3SmThUM42NI+yMlc/8V+wK8hVMhfuvn
 /nhwZ6qdJzctyaVTM7tyDMDXNA6wyILG16sope57gFUY8j02KNrFGj8Uvvs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pavel Machek <pavel@ucw.cz> schrieb am Thu, 28. Jun 22:45:
> On Thu 2018-06-28 22:29:57, Andreas Klinger wrote:
> > Hi Pavel,
> > 
> > Pavel Machek <pavel@ucw.cz> schrieb am Thu, 28. Jun 20:56:
> > > Hi!
> > > 
> > > > Send out a morse code by using LEDs.
> > > > 
> > > > This is useful especially on embedded systems without displays to tell the
> > > > user about error conditions and status information.
> > > > 
> > > > The trigger will be called "morse"
> > > > 
> > > > The string to be send is written into the file morse_string and sent out
> > > > with a workqueue. Supported are letters and digits.
> > > > 
> > > > With the file dot_unit the minimal time unit can be adjusted in
> > > > milliseconds.
> > > > 
> > > > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > > 
> > > Can we get more general "pattern" trigger? Some LEDs can do that in
> > > hardware, and it is more general than plain morse.
> > > 
> > > Ouch and it already was implemented :-). Patch is in attachment.
> > 
> > The idea of the morse trigger is so be able so send out a short error
> > code or if needed also a complete sentence. The morse code don't need
> > extra explanation to the user. Decoding can be found everywhere.
> 
> Yeah, well... I don't think decoding sentences in morse code is going
> to be much fun.
> 
> And we don't really want encoder in kernel. Just do encoding in
> userspace, and use pattern trigger to display it.
> 
> For many uses, morse code is "too geeky", and other patterns will be
> used.
> 
> Like " X    " for error 1, " X X     " for error 2, " .xX .xX " for
> charging, " .xXx. " for everything okay...
> 

The hardware i'm using is not able to adjust brightness. It can just switch the
LED on or off. That's it.

If anybody is interested i can submit a version 2 of the morse trigger with the
improvements suggested by Greg and Geert. Please let me know.

Andreas


> > With the pattern trigger one need a translation of the letters and
> > numbers into morse code. This is what the morse trigger is doing.
> > 
> > So from my perspective the pattern trigger is something different than
> > the morse one.
> 
> Well, pattern trigger is more generic, and can do everything morse
> trigger can do. Lets do that instead.
> 
> > Another question:
> > The pattern trigger is not in mainline. Do you know why?
> 
> Needs to be resubmitted, I'd say.
> 
> 								Pavel
> 
> > > +++ b/Documentation/leds/ledtrig-pattern.txt
> > > @@ -0,0 +1,86 @@
> > > +LED Pattern Trigger
> > > +===================
> > > +
> > > +This is a LED trigger allowing arbitrary pattern execution. It can do gradual
> > > +dimming. This trigger can be configured to repeat the pattern a number of
> > > +times or indefinitely. This is intended as a way of communication for embedded
> > > +systems with no screen.
> > > +
> > > +The trigger can be activated from user space on LED class devices as shown
> > > +below:
> > > +
> > > +  echo pattern > trigger
> > > +
> > > +This adds the following sysfs attributes to the LED:
> > > +
> > > +  pattern - specifies the pattern. See syntax below.
> > > +
> > > +  repeat - number of times the pattern must be repeated.
> > > +	writing -1 to this file will make the pattern
> > > +	repeat indefinitely.
> > > +
> > > +The pattern will be restarted each time a new value is written to
> > > +the pattern or repeat attribute. When dimming, the LED brightness
> > > +is set every 50 ms.
> > > +
> > > +pattern syntax:
> > > +The pattern is specified in the pattern attribute with an array of comma-
> > > +separated "brightness/length in miliseconds" values. The two components
> > > +of each value are to be separated by a space.
> > > +
> > > +For example, assuming the driven LED supports
> > > +intensity value from 0 to 255:
> > > +
> > > +  echo 0 1000, 255 2000 > pattern
> > > +
> > > +Or:
> > > +
> > > +  echo 0 1000, 255 2000, > pattern
> > > +
> > > +Will make the LED go gradually from zero-intensity to max (255) intensity
> > > +in 1000 milliseconds, then back to zero intensity in 2000 milliseconds:
> > > +
> > > +LED brightness
> > > +    ^
> > > +255-|       / \            / \            /
> > > +    |      /    \         /    \         /
> > > +    |     /       \      /       \      /
> > > +    |    /          \   /          \   /
> > > +  0-|   /             \/             \/
> > > +    +---0----1----2----3----4----5----6------------> time (s)
> > > +
> > > +
> > > +
> > > +To make the LED go instantly from one brigntess value to another,
> > > +use zero-time lengths. For example:
> > > +
> > > +  echo 0 1000, 0 0, 255 2000, 255 0 > pattern
> > > +
> > > +Will make the LED stay off for one second, then stay at max brightness
> > > +for two seconds:
> > > +
> > > +LED brightness
> > > +    ^
> > > +255-|        +---------+    +---------+
> > > +    |        |         |    |         |
> > > +    |        |         |    |         |
> > > +    |        |         |    |         |
> > > +  0-|   -----+         +----+         +----
> > > +    +---0----1----2----3----4----5----6------------> time (s)
> > > +
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
