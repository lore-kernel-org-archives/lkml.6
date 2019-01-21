Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C44CC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C54F2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548073350;
	bh=rjpJ3OtPv8SfBg0cbtbTqchymfjS2MZ+IuigArZZe4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GEaeHDXCPUuqL4Tw2bm0ZvLe9aLrFV4cKBDzx9fFYC97hGS3heJAFoTZdRLCxFSgs
	 AMDXUVeZiALzuGFMH+Fm2uz1Qp6gc/eseyiyFcUmnWvjR+BFvnuAkpOo72kK/uzY95
	 93xCSf62pk4Zue5iqEqdUploGh0fc127RI4i6l04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfAUMW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfAUMW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:22:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8682084A;
        Mon, 21 Jan 2019 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548073347;
        bh=rjpJ3OtPv8SfBg0cbtbTqchymfjS2MZ+IuigArZZe4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9L96MJUNTC0XUKZjl9rZ9f9yQvgetSi6Nwk7cCzlJQfiVxVfYw05U9New5B3pYec
         axYHWe8d3Kjy/JU4G1356Rr5tlic0dC48k9y66oHm2GAzRJrSLHNah1wL36SuYY2j8
         M/TBrVLspY33QvIhQWRb6LQLACxhoZACgaju+pFg=
Date:   Mon, 21 Jan 2019 13:22:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     anders.roxell@linaro.org, khalid.aziz@oracle.com,
        stable@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH backport for 4.19] selftests: Fix test errors related to
 lib.mk khdr target
Message-ID: <20190121122224.GC15873@kroah.com>
References: <20190116015922.17979-1-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116015922.17979-1-shuah@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 06:59:21PM -0700, shuah@kernel.org wrote:
> From: Shuah Khan <shuah@kernel.org>
> 
> Upstream commit 211929fd3f7c ("selftests: Fix test errors related to
> lib.mk khdr target")
> 
> This backport drops change to test that isn't in 4.19
> - tools/testing/selftests/tc-testing/bpf/Makefile

Thanks for the backport, now queued up.

greg k-h
