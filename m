Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AFAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4147D2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LQFL9VNk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LQFL9VNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4147D2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeHWBYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:24:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59696 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeHWBYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:24:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6F6F0602BA; Wed, 22 Aug 2018 21:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534975048;
        bh=Y0AQmL/Z4Erhq4mdWHcRdfRpQjQ20Ml6J4arlLkGz3s=;
        h=Date:From:To:Cc:Subject:From;
        b=LQFL9VNkYF/e8TgVbrZPhapvA6v+5JiZczyexAezW4LSte1TY0ISUgUPnX3b31hqp
         Vw916tuSVnpw/G5tRSSe+qa3ELa6G5Ioao4sXC2gMdIan+mV7TkuVU+qoWT//5+Iea
         AWqR4tIH6weLoAlWQSok3VOe4SYxppeNMddK03DQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3432C60227;
        Wed, 22 Aug 2018 21:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534975048;
        bh=Y0AQmL/Z4Erhq4mdWHcRdfRpQjQ20Ml6J4arlLkGz3s=;
        h=Date:From:To:Cc:Subject:From;
        b=LQFL9VNkYF/e8TgVbrZPhapvA6v+5JiZczyexAezW4LSte1TY0ISUgUPnX3b31hqp
         Vw916tuSVnpw/G5tRSSe+qa3ELa6G5Ioao4sXC2gMdIan+mV7TkuVU+qoWT//5+Iea
         AWqR4tIH6weLoAlWQSok3VOe4SYxppeNMddK03DQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Aug 2018 14:57:28 -0700
From:   pheragu@codeaurora.org
To:     Linux-arm Msm <linux-arm-msm@vger.kernel.org>,
        Linux Usb <linux-usb@vger.kernel.org>,
        Devicetree <devicetree@vger.kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Ckadabi <ckadabi@codeaurora.org>, Tsoni <tsoni@codeaurora.org>,
        Bryanh <bryanh@codeaurora.org>,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        Rnayak <rnayak@codeaurora.org>, psodagud@codeaurora.org
Subject: Reminder to review series of patches
Message-ID: <c0fd219eeba038e4d2375f5ff9c29ff8@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is reminder to review a series of patches sent a
week ago pertaining to EUD driver. These are the links for
the patches -

https://patchwork.kernel.org/cover/10568275/ - cover-letter
https://lore.kernel.org/patchwork/patch/975228/ - dt-binding
https://patchwork.kernel.org/patch/10568281/ - EUD driver

Regards,
Prakruthi Deepak Heragu
