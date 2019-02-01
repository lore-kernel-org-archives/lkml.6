Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB41C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC90218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549036709;
	bh=RohE9/awRzsFARTB1nzoto8kjZo6NLXjxTPxvHYNV6w=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=bL05CpCPs9DqpOdeL8bOuYfboPC51b7T7Cidnmr7j21RgGoGxQokiUU1/OeMMMaI0
	 WnW6w2J7hDSwleczyOW6TRlEKZd+Hqqd3YYGZMMPBY0iiOPTiZsYERGf/cvlufsBy/
	 LwHOlkiP4Prjtcfxoa3e6KRDRW+GgpS3lhhVoQas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfBAP62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAP61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:58:27 -0500
Received: from [192.168.0.101] (unknown [49.65.250.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC63E21872;
        Fri,  1 Feb 2019 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549036707;
        bh=RohE9/awRzsFARTB1nzoto8kjZo6NLXjxTPxvHYNV6w=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=eYQlWZoQmwIRJrz6DvSB4218rJDNA7zaCWgBXL5uK+zakA9S0r4w6nqZjRDJRzHqa
         6EQ0KqZ5HYBoSTER2G+y24xBpVgJfqGC4avlfzRgO4yE2QATFG4Nd4xKmB45SP5Fwp
         lcw02oeOK89L1baK2qZtBxhTssgRvk3SPf1GROh8=
Subject: Re: [f2fs-dev] [PATCH 3/7] f2fs: try to keep CP_TRIMMED_FLAG after
 successful umount
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-3-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <fe630d9c-0e5a-3e44-c8d4-5eddb1c729d7@kernel.org>
Date:   Fri, 1 Feb 2019 23:58:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190128234717.77225-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-1-29 7:47, Jaegeuk Kim wrote:
> If every discard were issued successfully, we can avoid further discard.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
