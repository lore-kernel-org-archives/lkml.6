Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6603CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2393B20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUuliEjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2393B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbeGIOmW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932909AbeGIOmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:42:19 -0400
Received: from [192.168.0.101] (unknown [49.77.238.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76ECF20878;
        Mon,  9 Jul 2018 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531147339;
        bh=q+Sfoy5iBj7ePLjVC+PPsHTjYxTTccQ/0zfStWz2MaU=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=oUuliEjqsLL30R+9QHCMY23N5GQQ1U7dGDg+GQNPN62U79sGzg7YtKxys3BK91bV7
         EP04jUQnEjRJm1j/0rZxI+fdSvHflovqI6ZoJHxENJ/2kPZ+zl3E1bLFbAe2ZJAy7l
         jgHffPX0NrAUH4r7U3ty+iLTFqXm+iYWx8FgYEic=
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: indicate shutdown f2fs to allow
 unmount successfully
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-3-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2bdae76c-abce-b9b5-512e-d1354589b369@kernel.org>
Date:   Mon, 9 Jul 2018 22:42:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180706210903.77887-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/7 5:09, Jaegeuk Kim wrote:
> Once we shutdown f2fs, we have to flush stale pages in order to unmount
> the system. In order to make stable, we need to stop fault injection as well.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
