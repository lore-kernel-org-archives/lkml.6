Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B5420865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="nPjBFOaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B5420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbeKVTMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:12:10 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:27824 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeKVTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:12:10 -0500
Date:   Thu, 22 Nov 2018 08:33:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1542875622;
        bh=7QTXHi1EGEoe9hgVMWVfoDPyWP7S1EAqoZchXbjA+bU=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=nPjBFOaMDCniV4bRlzIhSh6HhVBIahKEnwBDlUrRXsbF4T5d3Tet2+qJqtx/T4flQ
         xG/MjCNul4IFSDdFbi/iNKBqMvAZtv5jAtRSBBdW6hLG4WERH7KGjekFRgYoAfvtq6
         /vEoS6YbRugG5tEz2bu9R4YgYLk4pTpq/r39Is1o=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: Unix went to Plan 9 From Outer Space, Original Hacker Dennis Ritchie, became a  criminal to most.
Message-ID: <sYnWFcwedC5y8ZBGUByCwr_nuQiATKugEG2HFmvdateYG-fr-kGuqDATelvoKyfioC-EzQ1cisnVHtdHKPE6WNAt__Xx0NWh9irFYnnYVdI=@protonmail.com>
In-Reply-To: <DNbfa9eneYhk78gNqwSz8WQNaldwTEUjGUJdNTAUYabXQZdIB4H9fio4-G9PGh8RwHvKNNK1KXpmI_wInYw6jPjBTER3wSqavqMVmFBHZME=@protonmail.com>
References: <DNbfa9eneYhk78gNqwSz8WQNaldwTEUjGUJdNTAUYabXQZdIB4H9fio4-G9PGh8RwHvKNNK1KXpmI_wInYw6jPjBTER3wSqavqMVmFBHZME=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without philosophical coherency that is how regressions go.

LKML isn=C2=B4t really responding to these mails in the extent wanted, so i=
t seems of no use, to mail this list for serious reasons. Obviously the cha=
nge needs to come from elsewhere.

And seriously who uses a text-only mailing list in 2018? Plan 9 fans?

GNU is ofcourse also that. Linus threatening to kill over printers, Andrew =
Tanenbaums mushroom covers, Richard Stallman dances. A trinity of Plan 9 fa=
ns.

BeOS users also did this. Mimicked BeOS for 15 years, in "Haiku", probably =
only ultimately mimicking the bankrupcy of Be.

Do YOU want to go the way of Plan 9?

No? - Check out=C2=A0https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol=
_Q

=C3=9Cqq=C3=BCm for Fair Net Goods OS.

Linus "knows nothing" about economy, he says in interviews. Is not this to =
be retarded in computing space, that is the worlds biggest economy?

And obviously knows nothing about philosophy either, talking about "Unix" g=
uidelines, when Unix only went the way of Plan 9.

Philosophical coherency is needed, and here we have even realized a z=C3=
=ABn-concept of The Deity.

Something for serious actors, if there should be anyone left here at all.

Peace.
Ywe C=C3=A6rlyn
