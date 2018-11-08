Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91462C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F0B20817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N5UCVEdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F0B20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=whitewaterfoundry.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeKHOp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:45:28 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50393 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbeKHOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 09:45:28 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CF1AA21F49
        for <linux-kernel@vger.kernel.org>; Thu,  8 Nov 2018 00:11:47 -0500 (EST)
Received: from web4 ([10.202.2.214])
  by compute1.internal (MEProxy); Thu, 08 Nov 2018 00:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tfDMUC
        2ykUsXRQ+42/y5Ab9luo5eOkcge3dGsDt+cN4=; b=N5UCVEdf+RnMcNFzfO4gkB
        KFLW9M3WzMMdZzqu2leou1c+hvreT92b1ZoJq2X6vLknb9RvrKSMlgoZVE11abdX
        Ke2dgk6jeETDI63DO9cKKQmupkzPKzCGKSinG5IZ3vebjUhpSFZe+A1jeb0gQU/E
        u4yZiLqPH1DavsvdS/B/cfS4d2Yq7lktFDfBeREI6ad3bSlGIsHKe/NOPYUheAMT
        jbBBGqszGxTPo3ttQms63pZbR2daYJUaxe9RmJpOclaoewc96r+aJsPf22OdkN9q
        dOM8brt1NUXTxYEoadKLTcpKdZox8ighSO+WAhDse+CcKCLgcjKWXUBf0O7czAIQ
        ==
X-ME-Sender: <xms:k8XjW25UAv3ILHJSqBFHp-atFrBcarxGDRgWvqcvcgQQQbPMr71s3A>
X-ME-Proxy: <xmx:k8XjW6yWdr55n6dhVxyoIoSxJyLI-1LONG_UmbBgUzDMY8TyPpQ0qg>
    <xmx:k8XjW_e4HQKJNFqHYPsAm16NR5wi9bp6zjkUP3OvvpRVuEqdGlhqCQ>
    <xmx:k8XjW2eMN04Wb5ezRvXh4CY9IZOPRoUfppH-c1cqz6ZrBEt8CssnbA>
    <xmx:k8XjWxal4jMUGhNTtf43fLShlDjnUmQ3TFP-FPj895EkkDDG6sOL3g>
    <xmx:k8XjW3_41OA1xm4Uha67RSeosNGGH6l8eoxzdS5XzbkXWFE4aMlHAg>
    <xmx:k8XjW6XmcPl29s4Ydw6yIDi1EIxpBjJBskJT5raQxzu1g7dFkJeODQ>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 8D979BA7C4; Thu,  8 Nov 2018 00:11:47 -0500 (EST)
Message-Id: <1541653907.680493.1569636320.38B54221@webmail.messagingengine.com>
From:   Hayden Barnes <hayden@whitewaterfoundry.com>
To:     linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
Subject: Re: [QUESTION] Microsoft, WSL,
 and the Linux trademark (Edited For Readability)
Date:   Wed, 07 Nov 2018 21:11:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Caputo,

> In reading the news today, I stumbled across an article talking about a $=
20=20
> "linux-based distro" app for Windows 10.

Hello. That was my idea. Please allow me to address some of the concerns yo=
u raised.=20

> This is just a bundled userspace for WSL, there is no actual Linux in thi=
s thing,=20
> yet the trademarked Linux name is used throughout.
> Did Microsoft license the trademark or something?  Did I miss a memo?
> Does their joining the Linux Foundation as a Platinum member two years ag=
o=20
> include such use of the trademark?=20
> I'm confused by what seems to be total silence about what _appears_ to be=
 an=20
> obvious large-scale trademark abuse in everything WSL-related.
> Could somebody informed please shed some light on this?

The Linux trademark is owned by Linus Torvalds and administered by the Linu=
x Foundation=20
through the Linux Mark Institute: https://www.linuxmark.org. The Linux trad=
emark can be=20
used by third parties subject to a Sublicense Agreement:=20
https://www.linuxmark.org/programs/legal/trademark/sublicense-agreement.=20

The terms of the Sublicense Agreement permit the use of the Linux trademark=
 for derivative=20
goods and services that deploy, document, facilitate the use of, or enhance=
 Linux=C2=AD-based goods.

WLinux does contain a bootable Linux kernel in a base image.  The criticism=
 that 'WSL is=20
not Linux' is because the kernel is not executed when the base image is ins=
talled and run=20
from within the WSL layer on Windows 10. But WLinux can be used to patch an=
d build the=20
Linux kernel from sources to install on other devices, assist in deploying =
and configuring=20
Linux on other devices, and can cross-compile software using standard Linux=
 libraries,=20
all when running on WSL. For more about how WSL works for those unfamiliar:=
=20
https://github.com/sirredbeard/Awesome-WSL#overview. WLinux unquestionably =
contains=20
derivations of the Linux kernel, relies on the WSL re-implementation of Lin=
ux kernel syscalls,=20
and facilitates the use of and enhances Linux-based goods, all within the t=
erms of the=20
Linux Sublicense Agreement.

We obtained a valid Sublicense Agreement for the use of the Linux trademark=
 for WLinux=20
from the Linux Foundation before launching WLinux. All of our intellectual =
property=20
compliance disclosures are here:=20
https://github.com/WhitewaterFoundry/WLinux/blob/master/LICENSE.md

> The situation strikes me as harmful to the kernel as the majority of folk=
s being=20
introduced to "Linux" this way will be tricked into thinking they're using/=
supporting Linux.

Users who purchase WLinux from the Microsoft Store are supporting the Linux=
 ecosystem=20
and free software generally. Everyone working on WLinux are Windows and Lin=
ux users
who are committed to making the Linux software ecosystem accessible to as m=
any people=20
as possible regardless of what device or operating system they are on. WLin=
ux and WSL=20
generally opens up new possibilities for bringing people to the Linux ecosy=
stem,=20
cross-platform development, and expanding access to free software and free =
software=20
development tools.=20

WLinux builds in a number of value-added enhancements and features, we prov=
ide=20
end user support, and work with various developer communities and other ope=
n source=20
companies to try to make it easy to get into the Linux ecosystem from Windo=
ws 10.  We=20
make it easy to get up and running with Go, Ruby, other dev toolchains, soo=
n Docker, install=20
various editors, configure predictive text input for non-Latin input, and i=
mplement a handful=20
of other tweaks to defaults. I personally do not believe a frontend dev ste=
pping into Linux=20
should have to know how to partition and dual-boot a system, or even have t=
o learn Docker,=20
to get started using node.js and trying different packages off npm. They wi=
ll get to that.

Many WLinux users are going to end up working on traditional server Linux e=
ventually,=20
if they don't already, as many of our users seem to work in hybrid environm=
ents as it is.=20
I imagine a few will end up trying and then switching to desktop Linux, aga=
in if they don't=20
use it already. But desktop Linux is just one small part of Linux, WLinux i=
s not here to=20
replace it, and WSL is not capable of doing so in it's current limitations.=
 Users are not being
 'tricked'. Free upstream distros from Canonical, Debian, SuSE, and Kali ar=
e available where=20
you can implement our tweaks and custom packages manually. Of the many copi=
es we have
 sold we have only had two refund requests which we have promptly honored. =
Users always=20
have the option of building WLinux from source using instructions we provid=
e. WLinux is also=20
heavily discounted or free in many less developed countries.

We turn the funds WLinux earns around to hire open source developers, spons=
or bug and=20
feature bounties, donate to upstream projects, and cover overhead. We are p=
rofitable and=20
expect to pay out over $2,000 USD in bounties this month alone after being =
on the store for
 just six weeks. We are focused on building a sustainable commercial open s=
ource project=20
that can direct our own development resources where we see fit to improve t=
he Linux=20
experience on WSL for us, the users of Linux on WSL. Microsoft has had abso=
lutely zero=20
input into how we have evolved WLinux besides open source code of theirs we=
 have used.

Hayden Barnes
Whitewater Foundry, Ltd. Co.
hayden@whitewaterfoundry.com
https://www.whitewaterfoundry.com
https://twitter.com/WLinuxApp
https://github.com/sirredbeard
https://github.com/WhitewaterFoundry/WLinux
