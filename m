Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA94C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CE7218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="QWJAsOxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfBFVnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:43:43 -0500
Received: from erza.pados.hu ([176.9.136.194]:41628 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfBFVnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=To:Subject:From:Content-Type:Date:MIME-Version:From:
        Subject:To; bh=BeFnzPOgP7SDUFKa9XXlqu/yf5TUOxXrWEGIYDlSWfE=; b=QWJAsOxqTG1Evh
        f5cogaQruBg6QjRP6d1Qzdz7Hv3CtffH8mAkOPw5DwG1di1YFHQ4ABM4rg1YpxNFPWBb+mz6ux6Qt
        IwvD6KbWXGWnDVp4+nllf6KPBI8otXnIqd5719FKUsP0jV5ccg8GmPyi3FYlONtbZdlk1S2NRec4q
        nzKPwTYeC7GoJ5XpQWx5ddua1Mucrli+ZeqeAFp56l4o9zTohoheyTRl2GFBYTmuadnI4c5WHdOx8
        fa1ROnSygBRCsjMz0ScBMDEZzcpMvfs3xQToaCeWDlQGa4kEO3u4nuFuapP1zNlwMY3jIDa0jahVT
        iY/nXbMDLJxCQpz1FrNQ==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1grUyp-00074u-1z; Wed, 06 Feb 2019 22:43:39 +0100
MIME-Version: 1.0
Date:   Wed, 06 Feb 2019 21:43:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <7af148c7c37e625525141bfa7d23754a@pados.hu>
Subject: Re: [PATCH] USB: serial: cp210x: Fix GPIO in autosuspend
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190204160944.GH4686@localhost>
References: <20190204160944.GH4686@localhost>
 <20190115085743.GL3691@localhost> <20190114194352.4579-1-pados@pados.hu>
 <15f71a61af66817847d4b11b9e2e60e8@pados.hu>
 <20190115092607.GN3691@localhost> <20190115102942.GO3691@localhost>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Uhm, yes, sorry, it kind of went out of my head. I am doing
    a lot of travelling lately (in the past 48 hours I've been on 3 airplanes),
    and I had travels on earlier weeks too, mixed with some project [...] 
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

Uhm, yes, sorry, it kind of went out of my head. I am doing a lot of trav=
elling lately (in the=0Apast 48 hours I've been on 3 airplanes), and I ha=
d travels on earlier weeks too, mixed with=0Asome project releases and fa=
mily celebrations. So my head is just somewhere else.=0ARealistically, I'=
ll submit something by the weekend when I'm home again.=0A=0AKaroly=0A=0A=
February 4, 2019 5:09 PM, "Johan Hovold" <johan@kernel.org> wrote:=0A=0A>=
 On Tue, Jan 15, 2019 at 11:29:42AM +0100, Johan Hovold wrote:=0A> =0A>> =
On Tue, Jan 15, 2019 at 10:26:07AM +0100, Johan Hovold wrote:=0A>> On Tue=
, Jan 15, 2019 at 09:17:58AM +0000, Karoly Pados wrote:=0A>>>> I think it=
's better to add the autopm call to gpio210x_gpio_get/set=0A>>>> only. Th=
is will allow for a simpler patch, and keeps the autopm handling=0A>>>> c=
onfined to the gpio paths.=0A>>> =0A>>> I'll submit a v2.=0A>>> =0A>>>>> =
@@ -1383,6 +1397,7 @@ static void cp210x_gpio_set(struct gpio_chip *gc, u=
nsigned int gpio, int=0A>>>>> value)=0A>>>>> } else {=0A>>>>> u16 wIndex =
=3D buf.state << 8 | buf.mask;=0A>>>>> =0A>>>>> + usb_autopm_get_interfac=
e(serial->interface);=0A>>>> =0A>>>> Also make sure to always check for e=
rrors from autopm_get().=0A>>> =0A>>> I checked everywhere else, the reas=
on I didn't check here is on=0A>>> purpose based on your previous feedbac=
k. The caller function here=0A>>> doesn't have a return value, so the onl=
y way to return errors is to=0A>>> log, but in my last patch to ftdi_sio =
you made clear that errors from=0A>>> autopm_get shouldn't get logged. Tr=
ying to call usb_control_msg() even=0A>>> though the device could not wak=
e does not cause issues, and the return=0A>>> value from usb_control_msg(=
) clearly identifies the reason for failure=0A>>> (failure due to autosus=
pend), so error information is not lost either.=0A>>> So I thought not ch=
ecking here has no real disadvantage and I still=0A>>> stay conformant to=
 your previous guidance.=0A>> =0A>> Ok, I understand your reasoning, but =
please do check for errors and bail=0A>> out early if autopm_get() fails.=
 No need to log errors.=0A>> =0A>> Actually, we should probably add the m=
issing error handling to the=0A>> callers and have gpio_set() propagate e=
rrors too. If you want to take a=0A>> stab at that, that could be a follo=
w-on patch.=0A> =0A> Karoly, did you plan on sending a v2 of this one?=0A=
> =0A> Thanks,=0A> Johan
