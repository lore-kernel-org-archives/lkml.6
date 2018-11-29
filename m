Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADE9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1EB2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0x9xiFeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1EB2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeK3Kut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbeK3Kus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:50:48 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2A72146D;
        Thu, 29 Nov 2018 23:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543535013;
        bh=rU9Fpv+NCpQmEQW5TZp99eXiZ6dxE7ErSgJa+PijsiM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=0x9xiFeCJJR9PAxh/KVbfGVjd695fOBweA1xE01R26BaAkLWsgEyv4a7ZtQ43Hw7Z
         tnGdzwzg20Y2i71J4vlupBU9735zuySvqlUq97PPs0lALUv/ousCTjz0/5l7dJCIdV
         fbc73vGi52vrV/xsvv//7yBEMPqCmKXrsZ7rC0S8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181129164524.18670-2-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129164524.18670-1-jbrunet@baylibre.com>
 <20181129164524.18670-2-jbrunet@baylibre.com>
Message-ID: <154353501265.88331.14514779271643690989@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] dt-bindings: clk: meson: add ao controller clock inputs
Date:   Thu, 29 Nov 2018 15:43:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-11-29 08:45:22)
> Add the clock inputs of amlogic AO clock controller
> =

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

