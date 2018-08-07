Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2402C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2A521569
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2A521569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeHGW6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:58:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726468AbeHGW6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:58:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 820894023336;
        Tue,  7 Aug 2018 20:42:30 +0000 (UTC)
Received: from [10.40.204.67] (ovpn-204-67.brq.redhat.com [10.40.204.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3AC02166BA0;
        Tue,  7 Aug 2018 20:42:28 +0000 (UTC)
Subject: Re: [PATCH] Use Kconfig flag to remove support of deprecated BE2/BE3
 adapters
To:     poros@redhat.com
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20180806121230.23690-1-poros@redhat.com>
 <20180806.134620.124956510948789350.davem@davemloft.net>
 <322717b5-6d98-6f65-9357-190af5b50418@redhat.com>
 <20180807.132132.598894382052616071.davem@davemloft.net>
From:   Ivan Vecera <ivecera@redhat.com>
Message-ID: <45205403-69f8-898c-47f3-ebafce66fc89@redhat.com>
Date:   Tue, 7 Aug 2018 22:42:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180807.132132.598894382052616071.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 20:42:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 20:42:30 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ivecera@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.8.2018 22:21, David Miller wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> Date: Tue, 7 Aug 2018 13:44:52 +0200
> 
>> This patch is practically the same as "a1b8714593b6 ("net/mlx4: Use
>> Kconfig flag to remove support of old gen2 Mellanox devices")" for
>> mlx4 and that was accepted without any objections.
> 
> Ok, please resubmit this patch then.
> 
> Please add a proper Subject line subsystem prefix this time,
> "be2net: Use Kconfig flag ..." f.e.e
> 
I would extend the ability to configure the support also for the rest of chip
families (Lancer & Skyhawk) as Christoph suggested.

Ivan
