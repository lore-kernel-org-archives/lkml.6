Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPrnNHAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 200A6606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbeFFSug (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:50:36 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:34868 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbeFFSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:50:34 -0400
X-Google-Smtp-Source: ADUXVKJFtin3IwyjEiit7BRmoFT53zTg+NeatTfEGlSmTFTWOIb7SW+8gLgtoW0reHkWB0nTjbY2SRFUY0M0mScD9oA=
MIME-Version: 1.0
In-Reply-To: <xmqqwove4pzo.fsf@gitster-ct.c.googlers.com>
References: <xmqqwove4pzo.fsf@gitster-ct.c.googlers.com>
From: Duy Nguyen <pclouds@gmail.com>
Date: Wed, 6 Jun 2018 20:50:03 +0200
Message-ID: <CACsJy8ApqX16VNJ1nJktYVssXHTg+OSi_aZNt=es9BuUw9=1Cg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.18.0-rc1
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  * "git pull -recurse-submodules --rebase", when the submodule

One dash is missing in --recurse-submodules

>    repository's history did not have anything common between ours and
>    the upstream's, failed to execute.  We need to fetch from them to
>    continue even in such a case.
>    (merge 4d36f88be7 jt/submodule-pull-recurse-rebase later to maint).
-- 
Duy
