Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D8C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032222089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="n3oLz1HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032222089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbeG0QtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:49:11 -0400
Received: from node.akkea.ca ([192.155.83.177]:41156 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730771AbeG0QtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:49:11 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id CD51854204A; Fri, 27 Jul 2018 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1532705206; bh=TEHuvnk7dG5ETm+uVgvJvXHKEIEmmFhjjXbESWS3sKE=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=n3oLz1HNZkq7hJQIiUlELzQTzJfWz+qeGCuklBPzXebA70QEdcnx+RUo0PpGETUXI
         TLJC/ZEzV9ZCw5nyStei5T6MqWZoMZ0JQe48vd38oAlVVrg3TohO3UBwOOOq+RUmOU
         8sBF/L3ctfZ5HE51c5LU5HYgWCMFlL5FNDJlhySg=
To:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 2/4] power: bq25890_charger.c: Remove unused table
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Jul 2018 09:26:46 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAJKOXPeowiD7bXwRrG5horJOcxfEavB6XEmF8sz1unGDoykwoA@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca>
 <20180725194630.10414-3-angus@akkea.ca>
 <CAJKOXPeowiD7bXwRrG5horJOcxfEavB6XEmF8sz1unGDoykwoA@mail.gmail.com>
Message-ID: <98004c185428f0ff3ba7e21be29f9377@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-07-26 00:51, Krzysztof Kozlowski wrote:
> On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> The BATCMP table isn't used so drop it
> 
> TBL_VCLAMP also looks unused. TBL_IPRECHG does not have table entry.
> 

I as looking to drop the tables that would be problematic to the new 
part. Would you like me to resolve these 2 as well ?

Regards,
Angus

> Best regards,
> Krzysztof


