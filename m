Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF87C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE072214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4ykQmbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE072214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeLCR42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeLCR42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:56:28 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A1820848;
        Mon,  3 Dec 2018 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543859784;
        bh=OlwM6ZeUCdc9LYTEjXWmt5ek3UMyWxInY9c+rzoIVH0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=M4ykQmbzN1t3HxXK9u8VrM6hHpuyUzog4T/mlFYjTzrF+q9semODbOUcpydC/IIQm
         FxtR8UMzt0u6px42MGIkTjwqUylDUkQGrn/gMmZKNEf1cGq7fbrwvvoiKcJZkKK4Jl
         /Y1OMaAgS6aQ4zf8NsbInFlIQUc1BRHBJ/Utj3xs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203171640.12110-2-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181203171640.12110-1-jbrunet@baylibre.com>
 <20181203171640.12110-2-jbrunet@baylibre.com>
Message-ID: <154385978324.88331.12597456598061904548@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/3] dt-bindings: clk: meson: add ao controller clock inputs
Date:   Mon, 03 Dec 2018 09:56:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-12-03 09:16:38)
> Add the clock inputs of amlogic AO clock controller
> =

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

