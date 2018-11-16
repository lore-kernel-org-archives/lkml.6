Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C4FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C357420858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MFu0vMq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C357420858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbeKQJn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:43:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E/8E9CMR12qmYsD7ysSdymruaJFXONmS1/hgtsrhxTo=; b=MFu0vMq3ZDq6qcipu5YhzrIpLH
        RIHJ59T0IlQz1gRoycU0df3XVrW3+Z3AgaEzRjoe+rSUIHr4+ypkvYoc436CA/N3c0Bdg90zBQ5nz
        l8oulDwD/K/GiYxUl23NDyvRt4GAYYblZFyBbYfk0v1eNyklefyylVuJcb2r9oe6G2deJ6k7bgPPF
        8yZEJYFV8reotKYZD8vgr7MuRBiHOU610wTrumuxAVR43ot5xDP6aAfAnqY7VTme3OWOHM0mGZLoT
        p8PCnxL9O5580M51lInLnNjlEQ961o/JPVZ9I9MIlphQItDoj1BvEImz9J2EGXkBop1v9qziA1Egb
        u6tA+NjA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNnXn-0006DW-4H; Fri, 16 Nov 2018 23:28:59 +0000
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvdimm@lists.01.org, Dmitry Vyukov <dvyukov@google.com>,
        Steve French <stfrench@microsoft.com>,
        "Tobin C. Harding" <me@tobin.cc>, linux-media@vger.kernel.org
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181115074403.45d9a16a@silica.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <487ebe2d-1feb-298e-ef88-bf4443311cab@infradead.org>
Date:   Fri, 16 Nov 2018 15:28:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115074403.45d9a16a@silica.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 7:44 AM, Mauro Carvalho Chehab wrote:
> 
> Anyway, RFC patch follows.
> 
> -
> 
> [PATCH] [RFC] Add a system profile description for media subsystem
> 
> This RFC aligns with current Dan's proposal for having subsystem
> specific ruleset stored at the Kernel tree.
> 
> On this initial RFC, I opted to not add the reviewers e-mail
> (adding just a "<>") as a boilerplate. If we decide keeping emails
> there, I'll add them.

Hi-
Here are my comments.

Hopefully the email addresses will be added.  Just having names is a
half-answer for contact info.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> diff --git a/Documentation/media/subsystem-profile.rst b/Documentation/media/subsystem-profile.rst
> new file mode 100644
> index 000000000000..7a5d6f691d05
> --- /dev/null
> +++ b/Documentation/media/subsystem-profile.rst
> @@ -0,0 +1,186 @@
> +Media Subsystem Profile
> +=======================
> +
> +Overview
> +--------
> +
> +The media subsystem cover support for a variety of devices: stream

                       covers

> +capture, analog and digital TV, cameras, remote controllers, HDMI CEC
> +and media pipeline control.
> +
> +Both our userspace and Kernel APIs are documented and should be kept in
> +sync with the API changes. It means that all patches that add new
> +features to the subsystem should also bring changes to the corresponding
> +API files.
> +
> +Also, patches for device drivers that changes the Open Firmware/Device
> +Tree bindings should be reviewed by the Device Tree maintainers.
> +
> +Due to the size and wide scope of the media subsystem, our
> +maintainership model is to have sub-maintainers that have a broad
> +knowledge of an specific aspect of the subsystem. It is a

             of a specific

> +sub-maintainers task to review the patches, providing feedback to users
> +if the patches are following the subsystem rules and are properly using
> +the media internal and external APIs.
> +
> +We have a set of compliance tools at https://git.linuxtv.org/v4l-utils.git/
> +that should be used in order to check if the drivers are properly
> +implementing the media APIs.
> +
> +Patches for the media subsystem should be sent to the media mailing list
> +at linux-media@vger.kernel.org as plain text only e-mail. emails with

                               e-mail or email?  Be consistent. (more below)

> +HTML will be automacially rejected by the mail server.

                automatically

> +
> +Our workflow is heavily based on Patchwork, meaning that, once a patch
> +is submitted, it should appear at:
> +
> +   - https://patchwork.linuxtv.org/project/linux-media/list/
> +
> +If it doesn't automatically appear there after a few minutes, then
> +probably something got wrong on your submission. Please check if the
> +email is in plain text only and if your emailer is not mangling with

email

> +whitespaces before complaining or submit it again.
> +
> +Core
> +----
> +
> +Documentation
> ++++++++++++++
> +
> +F: Documentation/media
> +
> +Kernelspace API headers
> ++++++++++++++++++++++++
> +
> +F: include/media/*.h
> +
> +Digital TV Core
> ++++++++++++++++
> +
> +F: drivers/media/dvb-core
> +
> +HDMI CEC Core
> ++++++++++++++
> +
> +F: drivers/media/cec
> +
> +Media Controller Core
> ++++++++++++++++++++++
> +
> +F: drivers/media/media-\*.[ch]
> +
> +Remote Controller Core
> +++++++++++++++++++++++
> +
> +F: drivers/media/rc/rc-core-priv.h
> +F: drivers/media/rc/rc-ir-raw.c
> +F: drivers/media/rc/rc-main.c
> +F: drivers/media/rc/ir\*-decoder.c
> +F: drivers/media/rc/lirc_dev.c
> +
> +Video4linux Core
> +++++++++++++++++
> +
> +F: drivers/media/v4l2-core
> +
> +Patches or Pull requests
> +------------------------
> +
> +All patches should be submitted via e-mail for review. We use

and e-mail

> +pull requests on our workflow between sub-maintainers and the
> +maintainer.
> +
> +
> +Last day for new feature submissions
> +------------------------------------
> +
> +Before -rc5
> +
> +
> +Last day to merge features
> +--------------------------
> +
> +Before -rc7
> +
> +
> +Non-author Ack / Review Tags Required
> +-------------------------------------
> +
> +Not required, but desirable
> +
> +
> +Test Suite
> +----------
> +
> +Use the several *-compliance tools that are part of the v4l-utils
> +package.
> +
> +
> +Trusted Reviewers
> +-----------------
> +
> +Sub-maintainers
> ++++++++++++++++
> +
> +At the media subsystem, we have a group of senior developers that are
> +responsible for doing the code reviews at the drivers (called
> +sub-maintainers), and another senior developer responsible for the
> +subsystem as a hole. For core changes, whenever possible, multiple

             as a whole.

> +media (sub-)maintainers do the review.
> +
> +The sub-maintainers work on specific areas of the subsystem, as
> +described below:
> +
> +- Sensor drivers
> +
> +  R: Sakari Ailus <>
> +
> +- V4L2 drivers
> +
> +  R: Hans Verkuil <>
> +
> +- Media controller drivers
> +
> +  R: Laurent Pinchart <>
> +
> +- HDMI CEC
> +
> +- Remote Controllers
> +
> +  R: Sean Young <>
> +
> +- Digital TV
> +
> +  R: Michael Krufky <>
> +  R: Sean Young <>
> +
> +
> +Resubmit Cadence
> +----------------
> +
> +Provided that your patch is at https://patchwork.linuxtv.org, it should
> +be sooner or later handled, so you don't need to re-submit a patch.

Resubmit or re-submit?  Be consistent.

> +
> +Please notice that the media subsystem is a high traffic one, so it
> +could take a while for us to be able to review your patches. Feel free
> +to ping if you don't get a feedback on a couple of weeks.

                                       in a

> +
> +Time Zone / Office Hours
> +------------------------
> +
> +Media developers are distributed all around the globe. So, don't assume
> +that we're on your time zone. We usually don't work on local holidays or
> +at weekends. Please also notice that, during the Kernel merge window,
> +we're usually busy ensuring that everything goes smoothly, meaning that
> +we usually have a lot of patches waiting for review just after that. So
> +you should expect a higher delay during the merge window and one week
> +before/after it.
> +
> +
> +Checkpatch / Style cleanups
> +---------------------------
> +
> +Standalone style-cleanups are welcome, but they should be grouped per
> +directory. So, for example, if you're doing a cleanup at drivers
> +under drivers/media, please send a single patch for all drivers under
> +drivers/media/pci, another one for drivers/media/usb and so on.


> Cheers.- 
~Randy
