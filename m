Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DB82084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544474674;
	bh=bcUsIa4aih7i00yvzAZ8BvGLJfQl/k0/te3QHfkaajM=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=zx7h8ionuumNnlwWIDbcaeShSQ/P77UCmVubbYLEoJC78aG42AY9EPg7Pvg2+4K7N
	 /GnHGBbqmmyVYImi+H5s76EZ4GcFb400P4LgnmNIDdB66glQgJfFCce6B75fPImJ0g
	 ds562WraVUkrCUpwTj4/YgIDqs05ffJekEcsrBd4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DB82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeLJUod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbeLJUoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:44:32 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E689720821;
        Mon, 10 Dec 2018 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544474672;
        bh=bcUsIa4aih7i00yvzAZ8BvGLJfQl/k0/te3QHfkaajM=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=wHca8Nhea8MtGLE/7u8K/L5oaxrHKj22yRRJCe4N2QPSbDHsNRUErg/V1zxkI5kWP
         cHhPpjV+i/lih62ymjbFVpZXm4HaggqrgkbRh0dFAKoAd2ZU9WFOVCYKoZ2TDb5s1N
         j1s5w4MRIjGESF4khJOl5BASEA4BA5aUjYuJ2+3Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181207100144.GA21411@localhost.localdomain>
Message-ID: <154447467108.17204.9435382576631633133@swboyd.mtv.corp.google.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Subject: Re: [PATCH v7] clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181207100144.GA21411@localhost.localdomain>
Cc:     mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Mon, 10 Dec 2018 12:44:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-07 02:01:44)
> ROHM bd71837 and bd71847 contain 32768Hz clock gate. Support the clock
> using generic clock framework. Note, only bd71837 is tested but bd71847
> should be identical what comes to clk parts.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied to clk-next

