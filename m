Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCAEC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC02A20837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7qHN06w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC02A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeKBWU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeKBWU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:20:56 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD082081F;
        Fri,  2 Nov 2018 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541164428;
        bh=UyqVpKbyMBdzb6pYp5Iw0+sPgwV+guyul2qrZaUJ0GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7qHN06wzO+ZD+YObuIGC6+xzHzYRJzx/FKMzFBoGe95z26JH2ISpFMpjnaWTO41+
         JBvLdKUQVcukFW92kABirhcvxvtrzIBNOM0/d46urtRogIEQN+NrudpD6XfLo2mheF
         Uo+tDXvSPcDcvu+1I59l2xyKFIa03NomKZe+hp7k=
Date:   Fri, 2 Nov 2018 14:13:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Robert Foss <robert.foss@collabora.com>
Cc:     robdclark@gmail.com, airlied@linux.ie,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm: Move fence put to where failure occurs
Message-ID: <20181102131346.GA22209@kroah.com>
References: <20181102121313.23271-1-robert.foss@collabora.com>
 <299cd40c-32df-61bb-3dba-4c63f97c28b9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299cd40c-32df-61bb-3dba-4c63f97c28b9@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 01:29:25PM +0100, Robert Foss wrote:
> +stable

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
