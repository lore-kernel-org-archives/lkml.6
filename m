Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5A3C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CAC2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CAC2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJ3PHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:07:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeJ3PHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E219FC049585;
        Tue, 30 Oct 2018 06:15:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BAEF29363;
        Tue, 30 Oct 2018 06:15:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A924EB3DC7; Tue, 30 Oct 2018 07:15:30 +0100 (CET)
Date:   Tue, 30 Oct 2018 07:15:30 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH 0/6] drm/qxl: Remove checkpatch issues
Message-ID: <20181030061530.3npr2e3m6uwwxbza@sirius.home.kraxel.org>
References: <cover.1540579956.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540579956.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 30 Oct 2018 06:15:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 04:20:30PM -0300, Shayenne da Luz Moura wrote:
> This series cleans the following checkpatch.pl issues:
> 
> ERROR: trailing whitespace
> WARNING: Missing a blank line after declarations
> CHECK: Please don't use multiple blank lines
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> ERROR: space required before the open parenthesis '('
> CHECK: Avoid using bool structure members because of possible alignment issues

Patches queued up.

thanks,
  Gerd

