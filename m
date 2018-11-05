Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8638CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574342085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574342085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbeKFEjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:39:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38444 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbeKFEjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:39:01 -0500
Received: by mail-oi1-f195.google.com with SMTP id v83-v6so8511105oia.5;
        Mon, 05 Nov 2018 11:17:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezfmZeiONl94URb94qSMhkTawg5JXuYSft2Z1Q+PG8o=;
        b=DmAPGh3UdgoLppqE27cH1eMYU7zJwR0mRbBDiYk0B2BU5YZbhnV3aFVrJOzhbJ3C5D
         RmgUbF6NxwSx3cmfOfsA8bdqMyPhCnEPicMDAIg/S9AEFi5olMbJ1HdlJzxLDjUkft5v
         Gw3bVswNy+whFUwWnc3y/kiqLTzChngFf5O1k6GwWSGtZ5IH+cUW1dsCb2TL4IlG5khC
         v2V+a5QMaddtvvbHRDTJKiU4MukFTB38+pnMiUVyivR7Ks7Hnmsc22eOVKx0G4TeIwR8
         oWjcNk9dYHesdm7AEfxJ1DBOaBX81HNUaNa3eiNXp9fCo2UwHWPZWENyhX1oBvOtyavB
         cOPw==
X-Gm-Message-State: AGRZ1gJbZzoF/pCnstJ1qeN9H/HtXLCEbtnQ8CwlLjEhzNLdRlrEIxKQ
        1zD/HU6azMrzk0ilBcjvkWuRxSQ=
X-Google-Smtp-Source: AJdET5f7M5T5LKeQRSZP9pYe9HBGQCn0vQVVAOuom6k6p+9Plbb9TlU0ovZNfp+KDk70he1bgQpJvQ==
X-Received: by 2002:aca:5907:: with SMTP id n7-v6mr14440336oib.166.1541445473273;
        Mon, 05 Nov 2018 11:17:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m63-v6sm15431304oia.30.2018.11.05.11.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:17:52 -0800 (PST)
Date:   Mon, 5 Nov 2018 13:17:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Documentation: remove unmaintained todo file
Message-ID: <20181105191751.GA18970@bogus>
References: <1539573739-2108-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539573739-2108-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 08:22:19PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The todo.txt file was created by a previous maintainer and has
> never been updated by the current OPEN FIRMWARE AND FLATTENED
> DEVICE TREE maintainers.  Remove the out of date file.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  Documentation/devicetree/todo.txt | 10 ----------
>  1 file changed, 10 deletions(-)
>  delete mode 100644 Documentation/devicetree/todo.txt

Some of this stuff I'd say is still todo, but having this file present 
isn't serving any purpose towards getting them done. So I've applied.

Rob
