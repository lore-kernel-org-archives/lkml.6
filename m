Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA67C282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187542184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfA3NYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:24:12 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:60119 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3NYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:24:11 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gopqc-000290-Hr; Wed, 30 Jan 2019 06:24:10 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gopqb-00015D-MN; Wed, 30 Jan 2019 06:24:10 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
References: <87va2716mh.fsf@xmission.com>
        <9151.1548852654@warthog.procyon.org.uk>
Date:   Wed, 30 Jan 2019 07:24:00 -0600
In-Reply-To: <9151.1548852654@warthog.procyon.org.uk> (David Howells's message
        of "Wed, 30 Jan 2019 12:50:54 +0000")
Message-ID: <877eemth1r.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gopqb-00015D-MN;;;mid=<877eemth1r.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18y+i5H2fsJ1Ns5Q9Z57XL3Wyf2dIr9w7I=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFD] A mount api that notices previous mounts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> You need to rebase on linus/master.  A bunch of your patches are obsoleted by
> Al's security changes there.

Before anything is merged definitely.

Al dealt with mount options from the LSMs in a slightly different way
than I did.  At a practical level Als version of the changes to the LSMs
and mine are you say po-tae-toe I say po-tah-toe differences so I don't
see that influencing semantics up at the api level.

For purposes of disucssing an API (not of merging one) I chose to start
with code I had a reasonable amount of testing against, so that other
people could play with it without expecting trouble.

Eric

