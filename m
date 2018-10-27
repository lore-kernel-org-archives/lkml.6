Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4315FC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 22:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93A420828
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 22:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93A420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeJ1GwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 02:52:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:57638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbeJ1GwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 02:52:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83C30AFA8;
        Sat, 27 Oct 2018 22:09:47 +0000 (UTC)
Date:   Sun, 28 Oct 2018 00:09:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim.Bird@sony.com
cc:     viro@ZenIV.linux.org.uk, visionsofalice@redchan.it,
        linux-kernel-owner@vger.kernel.org, rms@gnu.org,
        ksummit-discuss@lists.linuxfoundation.org, mishi@linux.com,
        gregkh@linuxfoundation.org, bruce@perens.com,
        linux-kernel@vger.kernel.org, esr@thyrsus.com, moglen@columbia.edu,
        bkuhn@sfconservancy.org, neil@brown.name, editor@lwn.net
Subject: Re: [Ksummit-discuss] The linux devs can rescind their license
 grant.
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF88A2A727@USCULXMSG01.am.sony.com>
Message-ID: <nycvar.YFH.7.76.1810280000440.23511@cbobk.fhfr.pm>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com> <185b786a2bd6e8d527dca161dc42e4f1@redchan.it> <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com>
 <20181025204718.GB25649@thunk.org> <20181025214123.GA2448@thyrsus.com> <20181025230656.GJ32577@ZenIV.linux.org.uk> <75eb4a46c8a2c1d4a927760fd1f2009d@redchan.it> <20181027073241.GM32577@ZenIV.linux.org.uk>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A2A727@USCULXMSG01.am.sony.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Oct 2018, Tim.Bird@sony.com wrote:

> Al,
>
> Can you please, even in the face of comments you find irritating, keep 
> your responses more civil?  Calling someone a "wankstain" is 
> unprofessional

Tim,

to be completely honest, communicating anonymously doesn't really match my 
"this is highly professional" standards either, so I don't think we should 
be losing too much sleep over this particular e-mail exchange.

CoC explicitly requires us to be reasonably nice to the human being on the 
other end of the wire, which I whole-heartedly believe is a very noble and 
nice goal. But you really have to know at least a little bit who's there 
on the other end. Otherwise failure to communicate might be sort of 
inevitable.

-- 
Jiri Kosina
SUSE Labs

