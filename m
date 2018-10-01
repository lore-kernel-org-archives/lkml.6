Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC4BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B952084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="l1e2zUzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B952084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeJAKlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:41:07 -0400
Received: from cock.li ([185.100.85.212]:41274 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbeJAKlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:41:07 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1538366720; bh=x2iRQJm2wQGtoJ/4x9n8JuLkiOWimm7rSvUxvCJ45Tw=;
        h=Date:From:To:Cc:Subject:From;
        b=l1e2zUzz7xsonAeATbzca/RL4/T/Qa/SxnsygZmOC8eRdPIZ/oD31Z7O2ReJp8nq0
         qMqnFOxd3kNq/baMSlD0YmF9MGd2eX82U9kjqFk073WZ3TxcOlC807f2IX88dueM4y
         pKwE8tJyNeOKJGk5d8EUVyrfz25qs9+yTnxlMYB1eRg4cr8ksUveoTKPL7tWofy5WV
         H0cFpJST1o43wroTvihmOAA5j+BV3+3l5SOHjN5VPDhHjjRqv4Cg/lKsf7fK34dkS4
         dqcJAnbeIUFaZy7S19djxTp3YSnZvTrssFaUlBMdVJuv17ZKn9dKsaYJ3ZYAvSC+cG
         Rdlvb9UJy2uMA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Oct 2018 04:05:20 +0000
From:   freedomfromruin@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     rms@gnu.org, bruce@perens.com, esr@thyrsus.com,
        moglen@columbia.edu, bkuhn@sfconservancy.org, editor@lwn.net
Subject: Why the FSF collects copyright assignments.
Message-ID: <0eed2e2037a36216ecb42394784cc373@redchan.it>
X-Sender: freedomfromruin@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paramount reason Eben Moglen has the FSF accepting contributions 
only with copyright assignment is because the grantor of a license that 
is a gratuity (no consideration (read: usually money) given) can remove 
the permission regarding the use of his property at his pleasure.

(Regardless of the story that was promulgated for the public ("only to 
have standing to sue under copyright, since the GPL is a bare license 
and does not give rise to contract damages") - which was and is a 
half-truth only (Yes: you do need to own the rights to a work to sue 
under copyright, Yes the GPL is a bare license, No: that's not the whole 
reason why one would want the author to no-longer hold the copyright))
