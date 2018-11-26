Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBAAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC302133F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC302133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeK0Ctp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:49:45 -0500
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:36350 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726167AbeK0Ctp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:49:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8DB45181D38F4;
        Mon, 26 Nov 2018 15:55:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rub45_67a45d4321e4d
X-Filterd-Recvd-Size: 2784
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 26 Nov 2018 15:55:12 +0000 (UTC)
Message-ID: <52ff06c49ec35599b3c8edf3bd3d1acbb9397c91.camel@perches.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        zwisler@kernel.org
Date:   Mon, 26 Nov 2018 07:55:10 -0800
In-Reply-To: <20181126091229.04b5dce0@coco.lan>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
         <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
         <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
         <20181115061036.1575223d@silica.lan>
         <20181115162008.GO3759@mtr-leonro.mtl.com>
         <CABVU7+twSz3OZx7PTO+bS-wfLfTTjZVhRAnhgtcs6KWwntattw@mail.gmail.com>
         <CAPcyv4hWK+to6vOSfSdeVMDzUutYwg9=XqshSDzaCf0c-u8jLA@mail.gmail.com>
         <20181118110324.543edbd8@coco.lan> <8736rwgoem.fsf@intel.com>
         <20181126091229.04b5dce0@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 09:12 -0200, Mauro Carvalho Chehab wrote:
> Hi Jani,
> 
> Em Tue, 20 Nov 2018 10:10:25 +0200
> Jani Nikula <jani.nikula@intel.com> escreveu:
> 
> > On Sun, 18 Nov 2018, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > > Hmm.. Perhaps the subsystem profile should point to IRC channels if any?
> > > Several subsystems use them in order to provide newbies some directions
> > > and to discuss other development issues.  
> > 
> > MAINTAINERS:
> > 
> > 	C: URI for chat protocol, server and channel where developers
> > 	   usually hang out, for example irc://server/channel.
> > 
> > Alas very few subsystems have added that.
> > 
> > I actually fear very few subsystems will add a subsystem profile for
> > that matter.
> 
> Sorry for a late reply. In the case of the media subsystem, we
> actually use 2 different channels, one when the matter is related
> to digital TV (#linuxtv) and another one for the rest (#v4l), both
> at freenode.
> 
> That's something that wouldn't fit well into MAINTAINERS file, as
> we can't explain what should be used for each.
> 
> So, the way it is it won't work well for us.

So maybe add a comment to both like:

C:	<URI1>		# only for digital tv #linuxtv
C:	<URI2>		# everything else


