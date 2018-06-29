Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC46C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C7328058
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C7328058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964855AbeF2P0Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:26:24 -0400
Received: from ms.lwn.net ([45.79.88.28]:33146 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936716AbeF2P0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:26:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4FA2FC36;
        Fri, 29 Jun 2018 15:26:20 +0000 (UTC)
Date:   Fri, 29 Jun 2018 09:26:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Michael Rodin <michael-git@rodin.online>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/admin-guide/README.rst: add a label for
 cross-referencing
Message-ID: <20180629092619.409ab865@lwn.net>
In-Reply-To: <20180603181609.7015-1-michael-git@rodin.online>
References: <20180603181609.7015-1-michael-git@rodin.online>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Jun 2018 20:16:09 +0200
Michael Rodin <michael-git@rodin.online> wrote:

> Add a label to the top of the file to allow cross-referencing.
> Currently it's not possible to cross-reference this file from
> Documentation/process/howto.rst because of the missing label.
> 
> Signed-off-by: Michael Rodin <michael-git@rodin.online>

Finally applied (and the howto.rst one as well), thanks.

jon
