Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE42CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B51F20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtU69ZUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B51F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeKLH5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 02:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbeKLH5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 02:57:04 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D73D20869;
        Sun, 11 Nov 2018 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541974032;
        bh=PUDGiw2FljzeRJSiIhNYjhEd/9FN1Dgxentb5SWAgIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtU69ZUYMv7xmY4TvHH6yJIdD343CSAHDZJh5NuqYxZhwdFhzDgxdqQiUmYzAUMTI
         zMSyuzI6UzR6iB2acfbphM8a4UOzDaq8xFhRa+ZirbzxP7IEDRMM/DTyowUn4JdwSN
         S7OoYFdv+d3uKxh+9C9jb5/2qCnPgM4hVUgrgLWw=
Date:   Sun, 11 Nov 2018 17:07:08 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     LEROY Christophe <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 05/30] powerpc/traps: restore recoverability
 of machine_check interrupts
Message-ID: <20181111220708.GA2642@sasha-vm>
References: <20181104135325.88524-1-sashal@kernel.org>
 <20181104135325.88524-5-sashal@kernel.org>
 <20181111165017.Horde.p-JAEzMAEZNYBCQTqILU4A1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181111165017.Horde.p-JAEzMAEZNYBCQTqILU4A1@messagerie.si.c-s.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 04:50:17PM +0100, LEROY Christophe wrote:
>Looks like this patch didn't make its way into 4.14 yet. Is there a 
>problem with this patch ?

Nope. AUTOSEL patches take longer to cook and get merged.

--
Thanks,
Sasha
