Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9F7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29572183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547237645;
	bh=Tns2HzlCPwGUIO5h0kc6dWRc81keKGWJOGbTkIDsrtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s06iSm1kTo231EP8ai2d7NeUb/j3DzI9cFRuhi2EDfc6HqsVq5ilzHQzfeXyUmTqV
	 feIMnOSr7/RGN3XTWM4Cim+pStHvJqf0cEpZQ9abmdqWcpSgW/UyzvNA8DDXR7mx4Q
	 qy800RPlZBbehn9Nww2zi6ENRYq65I9K51nQU2OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390721AbfAKUOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:14:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46985 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387951AbfAKUOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:14:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so14197034otm.13;
        Fri, 11 Jan 2019 12:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7AT1paUpexE0fxOgLbS01YsTZMkfGBrjy2UmVen7/Q=;
        b=Bey2+6DrbaZb5q2x0TRW6grHUuNxrqyf8+BnbPlXlzq7TFwVniij6/bYTBUx41SPtJ
         OsW7ce96Moen91C6RIe9CR7LsHRZQJz/VnbPc3bnndsqcBjEZcIQN1Gp7yWKdENcgaDI
         spqfLwHSAqAIpYUtFAMgdrp9hZAqyes+O2gzYxVK/EWkUKz3CKmLODLlDdgK2wgZLZhV
         avTJ3sHo2qqiYh3vYNxkNnCV1ach2+RapJDDa2DorHSkRFaYbDC9ZtmMPB9bKxwTZAHJ
         ygpdkVtKYdThu0cEUjp9AqDl1kJjT9WZs35AyLaseLPc5ZQhAedU6NDbSsaPG3encSgF
         FV+Q==
X-Gm-Message-State: AJcUukfH3LX44diVHkIdKYOtBNCWNtYrf1E4aKmzWzhF7DwhOg0h+reA
        93s9wQFG574rT+gYEYT4Nd8yjr3e/Q==
X-Google-Smtp-Source: ALg8bN7fkDB+k1ARB/nhz26/XhyhW4sFirvLzsMRQovG8JvU+0oEZIfyseFcDYZNeDBWFQEXl+TrHg==
X-Received: by 2002:a9d:a83:: with SMTP id 3mr10962331otq.88.1547237642888;
        Fri, 11 Jan 2019 12:14:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o2sm40211341otj.2.2019.01.11.12.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 12:14:02 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:14:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: marvell,mmp2: fix typos in bindings doc
Message-ID: <20190111201401.GA1349@bogus>
References: <20190104215656.23002-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104215656.23002-1-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 10:56:56PM +0100, Lubomir Rintel wrote:
> A pair of rather trivial ones.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - s/identifier/identifiers/ as suggested by Rob Herring
> 
>  Documentation/devicetree/bindings/clock/marvell,mmp2.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob
