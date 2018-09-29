Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4B1C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51F520779
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51F520779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeI2HmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:42:09 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:35825 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbeI2HmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:42:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 09C49837F24A;
        Sat, 29 Sep 2018 01:15:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: view19_6c40946015454
X-Filterd-Recvd-Size: 7441
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Sep 2018 01:15:43 +0000 (UTC)
Message-ID: <da894e81adc28ac98d9c399d24d8eb075b30fd1a.camel@perches.com>
Subject: Re: Bad MAINTAINERS pattern in section 'STAGING - FLARION FT1000
 DRIVERS'
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Marek Belisko <marek.belisko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 28 Sep 2018 18:15:42 -0700
In-Reply-To: <20180929004649.GA28840@kroah.com>
References: <20180928220423.31573-1-joe@perches.com>
         <20180929004649.GA28840@kroah.com>
Content-Type: multipart/mixed; boundary="=-RFmC/VaXp9Qmu4b12llD"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RFmC/VaXp9Qmu4b12llD
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Fri, 2018-09-28 at 17:46 -0700, Greg Kroah-Hartman wrote:
> On Fri, Sep 28, 2018 at 03:04:23PM -0700, Joe Perches wrote:
> > Please fix this defect appropriately.
> > 
> > linux-next MAINTAINERS section:
> > 
> > 	13899	STAGING - FLARION FT1000 DRIVERS
> > 	13900	M:	Marek Belisko <marek.belisko@gmail.com>
> > 	13901	S:	Odd Fixes
> > -->	13902	F:	drivers/staging/ft1000/
> > 
> > Commit that introduced this:
> > 
> > commit a0138163cfbfdfbdc20e4477c77bd7046bd66bb4
> >  Author: Joe Perches <joe@perches.com>
> >  Date:   Tue Jul 5 15:21:34 2011 -0700
> >  
> >      MAINTAINERS: Add remaining staging entries
> >      
> >      Add the staging entries from various TODO files
> >      to MAINTAINERS.  Add a few web links as well.
> >      
> >      Miscellaneous staging typo section header fix.
> >      
> >      Signed-off-by: Joe Perches <joe@perches.com>
> >      Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> >  
> >   MAINTAINERS | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 68 insertions(+), 1 deletion(-)
> 
> So you are going to fix this, considering you created the problem?

_I_ did not create this problem.

You neglected to read the commit information below this in the
parent email.

When I wrote the MAINTAINERS patch in 2011, the files existed.

The files were removed in 2015 and you signed-off on their removal.

----------------------------------------------
Last commit with drivers/staging/ft1000/

commit 6512edec48b2ccfe9bb969ce26ebbbcd49de6c4b
Author: Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed Oct 21 18:42:37 2015 -0700

    staging: ft1000: remove obsolete driver
    
    Remove support for Qleadtek Flash-OFDM modems. Telecom carrier is
    discontinuing service for the radio technology.
    See http://www.gtigroup.org/news/ind/2015-08-18/6996.html.
    
    Suggested-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
----------------------------------------------

> This is an odd request to make of yourself in public, or was this a
> script gone wrong?

It was not a script gone wrong, though the output and emails
were scripted.

> confused,

No worries, it's easy to miss stuff.

fyi: the silly script I wrote is attached

Done using the latest -next with an empty patterns directory

$ perl ./scripts/get_maintainer.pl --self-test=patterns | \
  cut -f2 -d: | \
  while read line ; do \
    perl ./dump_section.perl $line \
  done


--=-RFmC/VaXp9Qmu4b12llD
Content-Type: application/x-perl; name="dump_section.perl"
Content-Disposition: attachment; filename="dump_section.perl"
Content-Transfer-Encoding: base64

bXkgJGkgPSAkQVJHVlswXTsKCm15IEBvdXRwdXQgPSAoKTsKbXkgQGxpbmVzID0gKCk7Cm9wZW4g
KG15ICRtYWludCwgJzwnLCAiTUFJTlRBSU5FUlMiKQogICAgb3IgZGllICIkUDogQ2FuJ3Qgb3Bl
biBNQUlOVEFJTkVSUyBmaWxlICdNQUlOVEFJTkVSUyc6ICQhXG4iOwp3aGlsZSAoPCRtYWludD4p
IHsKICAgIG15ICRsaW5lID0gJF87CiAgICBwdXNoKEBsaW5lcywgJGxpbmUpOwp9CmNsb3NlKCRt
YWludCk7CgpteSAkbG93X2luZGV4ID0gJGkgLSAxOwoKd2hpbGUgKCRsaW5lc1skbG93X2luZGV4
XSA9fiAvXi46LyAmJiAkbG93X2luZGV4ID4gMCkgewogICAgJGxvd19pbmRleC0tOwp9CgpteSAk
aGlnaF9pbmRleCA9ICRpIC0gMTsKd2hpbGUgKCRsaW5lc1skaGlnaF9pbmRleF0gPX4gL14uOi8g
JiYgJGhpZ2hfaW5kZXggPCAkI2xpbmVzKSB7CiAgICAkaGlnaF9pbmRleCsrOwp9CgpwdXNoKEBv
dXRwdXQsICJQbGVhc2UgZml4IHRoaXMgZGVmZWN0IGFwcHJvcHJpYXRlbHkuXG4iKTsKcHVzaChA
b3V0cHV0LCAiXG4iKTsKCnB1c2goQG91dHB1dCwgImxpbnV4LW5leHQgTUFJTlRBSU5FUlMgc2Vj
dGlvbjpcbiIpOwpwdXNoKEBvdXRwdXQsICJcbiIpOwoKd2hpbGUgKCRsb3dfaW5kZXggPCAkaGln
aF9pbmRleCkgewogICAgcHVzaChAb3V0cHV0LCAiLS0+IikgaWYgKCRsb3dfaW5kZXggPT0gJGkt
MSk7CiAgICBwdXNoKEBvdXRwdXQsICJcdCIgLiAoJGxvd19pbmRleCsxKSAuICJcdCIgLiAkbGlu
ZXNbJGxvd19pbmRleF0pOwogICAgJGxvd19pbmRleCsrOwp9CgpteSBAYmxhbWUgPSBgZ2l0IGJs
YW1lIC1MJGksKzEgTUFJTlRBSU5FUlNgOwpteSBAY29tbWl0cyA9IHNwbGl0KCcgJywgJGJsYW1l
WzBdKTsKbXkgJGNvbW1pdCA9ICRjb21taXRzWzBdOwpteSBAY29tbWl0X2xpbmVzID0gYGdpdCBs
b2cgLTEgLS1zdGF0ICRjb21taXRgOwpwdXNoKEBvdXRwdXQsICJcbkNvbW1pdCB0aGF0IGludHJv
ZHVjZWQgdGhpczpcblxuQGNvbW1pdF9saW5lcyIpOwoKbXkgJGZpbGUgPSAkbGluZXNbJGktMV07
CiRmaWxlID1+IHMvXltBLVpdOlxzKy8vOwpjaG9tcCAkZmlsZTsKCm15IEBmb2xsb3cgPSBgZ2l0
IGxvZyAtLWZvbGxvdyAtMSAtLXN0YXQgLU0gLS0gJyRmaWxlJ2A7CmlmICghQGZvbGxvdykgewog
ICAgcHVzaChAb3V0cHV0LCAiXG4iKTsKICAgIHB1c2goQG91dHB1dCwgIk5vIGNvbW1pdCB3aXRo
ICRmaWxlIGZvdW5kXG4iKTsKICAgIHB1c2goQG91dHB1dCwgIlxuIik7Cn0gZWxzZSB7CiAgICBt
eSAkY29tbWl0ID0gJGZvbGxvd1swXTsKICAgICRjb21taXQgPX4gcy9eY29tbWl0IC8vOwogICAg
QGZvbGxvdyA9IGBnaXQgbG9nIC0tc3RhdCAtMSAtTSAkY29tbWl0YDsKICAgIHB1c2goQG91dHB1
dCwgIlxuIik7CiAgICBwdXNoKEBvdXRwdXQsICJMYXN0IGNvbW1pdCB3aXRoICRmaWxlXG4iKTsK
ICAgIHB1c2goQG91dHB1dCwgIlxuIik7CiAgICBwdXNoKEBvdXRwdXQsIEBmb2xsb3cpOwp9Cgpt
eSBAbWFpbnRhaW5lcnMgPSBncmVwKC9eXHMrXGQrXHMrW0xSTV06LiokLywgQG91dHB1dCk7Cm15
IEBzaWduZXJzID0gZ3JlcCgvXlxzKy4qLWJ5Oi4qJC8sIEBvdXRwdXQpOwoKb3BlbiAobXkgJGZp
bGVoLCAnPicsICJwYXR0ZXJucy8kaS50eHQiKTsKCm15ICRzZWN0aW9uID0gJG91dHB1dFs0XTsK
JHNlY3Rpb24gPX4gcy9eXHMrXGQrXHMrLy87CiRzZWN0aW9uID1+IHMvXG4kLy87CgpwcmludCAk
ZmlsZWggIlN1YmplY3Q6IEJhZCBNQUlOVEFJTkVSUyBwYXR0ZXJuIGluIHNlY3Rpb24gJyRzZWN0
aW9uJ1xuIjsKcHJpbnQgJGZpbGVoICJcbiI7CnByaW50ICRmaWxlaCAoQG91dHB1dCk7Cgpmb3Jl
YWNoIG15ICRtIChAbWFpbnRhaW5lcnMpIHsKICAgICRtID1+IHMvXlxzK1xkK1xzKy46XHMrLy87
CiAgICAkbSA9fiBzL1xzKlwoLipcKS4qJC8vOwp9Cgpmb3JlYWNoIG15ICRzIChAc2lnbmVycykg
ewogICAgJHMgPX4gcy9eXHMqW1x3XC1dKy1ieTpccyovLzsKfQoKI3ByaW50ICRmaWxlaCAoIlxu
bWFpbnRhaW5lcnM6XG5cbiIpOwojcHJpbnQgJGZpbGVoIChAbWFpbnRhaW5lcnMpOwojcHJpbnQg
JGZpbGVoICgiXG5zaWduZXJzOlxuXG4iKTsKI3ByaW50ICRmaWxlaCAoQHNpZ25lcnMpOwoKbXkg
QGVtYWlscyA9ICgpOwpmb3JlYWNoIG15ICRlbWFpbCAoQG1haW50YWluZXJzLEBzaWduZXJzKSB7
CiAgICBwdXNoKEBlbWFpbHMsICRlbWFpbCkgdW5sZXNzICRheyRlbWFpbH0rKzsKfQoKI3ByaW50
ICRmaWxlaCAoIlxuZW1haWxzOlxuXG4iKTsKI3ByaW50ICRmaWxlaCAoQGVtYWlscyk7CgpteSAk
Y2MgPSAiIjsKZm9yZWFjaCBteSAkZW1haWwgKEBlbWFpbHMpIHsKICAgIG15ICR0ID0gJGVtYWls
OwogICAgJHQgPX4gcy9cbiQvLzsKICAgICR0ID1+IHMvIi8vZzsKICAgICRjYyAuPSAiIC0tY2Mg
XCIkdFwiIjsKfQoKY2xvc2UgJGZpbGVoOwoKbXkgJGdzbSA9ICJnaXQgc2VuZC1lbWFpbCAtLXRv
IFwibGludXgta2VybmVsXEB2Z2VyLmtlcm5lbC5vcmdcIiIgLiAkY2MgLiAiIHBhdHRlcm5zLyRp
LnR4dCI7CnByaW50KCIkZ3NtXG4iKTsKCm15IEBnc21fb3V0cHV0ID0gYCRnc21gOwoKcHJpbnQo
QGdzbV9vdXRwdXQpOwo=


--=-RFmC/VaXp9Qmu4b12llD--

