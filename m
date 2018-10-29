Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B16C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268732082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268732082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeJ3C3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:29:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44757 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeJ3C3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:29:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so4240015pgs.11;
        Mon, 29 Oct 2018 10:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1elt8IPWkTBZEpJODKoSmS5VMdMb8KY8f1IYC9AiGmM=;
        b=W60hqUnhR8qP4v6vYjymsMMPCPjIWUIriXdAf1FXL2aGexmMkP29rxoS7qZOF2jUuZ
         tTVgCh6WkEsTTJS+tjAYtqOTAKDIxyf7IhS4rOIiNBDVKYYL84a1oBYiib8FZERLOJKL
         qXDRooAgrFOrJ7rclJs5hLW8ZKWka/4102aFls3TY7T9RIr9LgbRKrxDWRMIehNlKlbj
         86RkIYAR+iR/beZh4GJ9sRVVnzkljWG0FF3XvE8PT6siZEr/+0VCIWFBMPCKXkxkGqJz
         cLcWtOnu5a7OlGQuW5BmXEaSjG7LOrdJAkiXYTnsYnhhgnPy1Xp69FNJedxjT5b6Xj6t
         owrw==
X-Gm-Message-State: AGRZ1gKhmyJUZrW6YDFXtVc16ikS1AR0+5FnM87FGNMJorKwizYpCbso
        IM7CpzalezKmwEm6GUmcNqSWcrEk
X-Google-Smtp-Source: AJdET5fnu3Ld51XVprBwV9HRR3fFAV0+wBEZa6n3mnGyDBeaQSRztQVt3O/ExWEhAgZ7+v8/y6guow==
X-Received: by 2002:a63:801:: with SMTP id 1mr14448058pgi.275.1540834812243;
        Mon, 29 Oct 2018 10:40:12 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id c128-v6sm15534996pfb.147.2018.10.29.10.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 10:40:11 -0700 (PDT)
Message-ID: <1540834809.196084.65.camel@acm.org>
Subject: Re: [PATCH 06/14] blk-mq: add 'type' attribute to the sysfs hctx
 directory
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Oct 2018 10:40:09 -0700
In-Reply-To: <20181029163738.10172-7-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
         <20181029163738.10172-7-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
+AD4 It can be useful for a user to verify what type a given hardware
+AD4 queue is, expose this information in sysfs.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

