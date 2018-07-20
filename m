Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED6FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBEF20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="tTlH4uR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBEF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390198AbeGTNbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:20 -0400
Received: from erza.pados.hu ([176.9.136.194]:42368 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389355AbeGTNbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sTn2Q/8VA/RRFUBAf2YTXwJu20L8XjIdWmtUP+6RYNA=; b=tTlH4uR2DIWinNSIbHMKVxUbzq
        P2dcudx6mL5IW89z/Me2UDgR4ni4YoPwEvuCFL3/gOqC0uiJraxozLr0wTJCS8cVbNE8x/0O7XyH/
        YTpvZXiBTJq/P52LEBWpWDsNSK60sLIQSQ09Ci2RYMHOGbWI+YMq7sfJ2BQmSJWvLYBw81fy003te
        h+U03TIYuo/XMvaxnJlQF/Mrc9ByJikGIqXc7hSed3CYtq7byxtygslY7IvroZh0QlriWUwnVJdX8
        WZkWSpqdExG55rca9DbChj6FC0FfS0zRKWY91gA6bxEYEexivV+rNPNg0D52yibWOZXqDG6PKjxyw
        v+3qDLYQ==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fgUka-00037U-14; Fri, 20 Jul 2018 14:43:12 +0200
MIME-Version: 1.0
Date:   Fri, 20 Jul 2018 12:43:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <6e6b5df11e7671da070195252a474e0f@pados.hu>
Subject: Re: [PATCH v2] USB: serial: cp210x: Implement GPIO support for
 CP2102N
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180720101629.GB19245@localhost>
References: <20180720101629.GB19245@localhost>
 <20180718212004.11852-1-pados@pados.hu>
 <ea05b80064d32c7beef3f2039adb89aa@pados.hu>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Thank you very much for squeezing this into your schedule.
    I've also become a lot more experienced now in contributing to the kernel,
    concerning both planning and code. Next time things should work out even
   smoother. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for squeezing this into your schedule. =0AI've also b=
ecome a lot more experienced now in contributing to the=0Akernel, concern=
ing both planning and code. Next time things should=0Awork out even smoot=
her.=0A=0AWish you a great and rewarding vacation!=0A=0AKaroly=0A=0AJuly =
20, 2018 12:16 PM, "Johan Hovold" <johan@kernel.org> wrote:=0A=0A> On Wed=
, Jul 18, 2018 at 09:38:12PM +0000, Karoly Pados wrote:=0A> =0A>> Hello J=
ohan,=0A>> =0A>> I hope maybe after you come back from your vacation you =
can still=0A>> merge this into 4.19, I guess the merge window will still =
be open.=0A> =0A> You shouldn't make assumptions about peoples vacation p=
lans. ;)=0A> =0A>> Given that there are=0A>> about another 5 weeks until =
4.19rc1 merge window closes,=0A>> I didn't think I'd be late with this pa=
tch, I am sorry.=0A> =0A> New code must be ready and reviewed well in tim=
e before the merge window=0A> *opens*. So generally you cannot expect any=
thing you post this week to=0A> be included in 4.19.=0A> =0A>> However, a=
s already explained to you, it'd be very important=0A>> for me to get thi=
s patch at least into 4.19, as otherwise the=0A>> time I loose is much gr=
eater than a single release cycle (due=0A>> to distro cycles), and I have=
 actually a crowdfunding product=0A>> depending on this.=0A> =0A> I know,=
 and I already cut some corners for you with the baud-rate=0A> handling c=
hanges even though this is strictly not a valid reason to=0A> change the =
normal procedures.=0A> =0A> That being said, I took a look at your gpio p=
atch today and as it looks=0A> like you've addressed the major concerns w=
ith v1, and done so in a clean=0A> way, I'll make an exception.=0A> =0A> =
I'll post some review comments, but I've already fixed up the patch=0A> m=
yself. It's mostly style issues, but I did also find two bugs.=0A> =0A> I=
 do need you to respin the commit message, though; a commit message=0A> s=
hould be self-contained and not rely on external discussions to make=0A> =
sense (you can of course still refer/link to it). Patch-revision info=0A>=
 should generally go below the cut-off line, unless it is useful to have=
=0A> it recorded.=0A> =0A> Can you post a reworked commit message today s=
o I can include this in my=0A> 4.19 updates?=0A> =0A> Thanks,=0A> Johan
