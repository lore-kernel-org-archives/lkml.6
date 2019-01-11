Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D365FC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962E92084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547244728;
	bh=DS5JNitD0e3Cj2gbJFesogeTeOmO4XXZqPOiWYD50Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OnR7DohJx2BiuVVboNLTl+Nm4UpyTTF/xN3cty5ggydzsgEUpU/Gcwodpn7NkJyNh
	 YVstbvA8DG0ZYmfpaQ0fArCNILKnZhNFO5r1qnX1oSrZeUFHPdQKh/5nahjt6fWPSH
	 j1dMN8NnMr8ueED3DrF/y35uMZyAnroK5drAzCjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfAKWMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:12:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37277 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfAKWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:12:07 -0500
Received: by mail-ot1-f67.google.com with SMTP id s13so5998499otq.4;
        Fri, 11 Jan 2019 14:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vqtkt5WV8SwYflc3uN7hXP9niRVwRim52jfkt+0R24E=;
        b=VhFYAIuTYGaAU1yisi0RjIfEipBVjZ/4SkSSZq3Y/+48Tx8JJolcqo2Q7PZm/hTSlj
         t/Idk4XRfcus1r9oEZtgg5GAJc3GxtqA1fMXch/B/GUnlF0tHfWAQdskwirSCi5EBPKj
         /6liDN8mb33fQ1KUde7vO7daJOy1b/7suKqFO/S3skk5tA7zESvmKVNpNuIoDNkRjNOD
         hNiuBy1jXnrRfusIu6t6Qt1BVeXol4xuq6H20PLgmlatgdWu8IlfXXWhrMhLeGQUvgYM
         FhVm5tpg4AaPgfvSb6hp6QRyJeo0NWarc36D1yXf+qtLeDjBXbzHnVNdFEcttoMvNTGZ
         5Kqg==
X-Gm-Message-State: AJcUukfTL5tYHwbJ0JystRSquCrc1GIHmJ3VjOkYN5XpueUEbAB+OuqT
        PI9Vhh8XtBrbX5hcXVfEqkm3bI9Ebg==
X-Google-Smtp-Source: ALg8bN6qPivUL/Z54bbkZq7ulevAc/5BNHUPlZZIGYI4JUWvRDnpwjpa/N6g3PSnBp5uJYKQM5wwqw==
X-Received: by 2002:a9d:6a1a:: with SMTP id g26mr11303402otn.172.1547244726750;
        Fri, 11 Jan 2019 14:12:06 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm59795014otj.19.2019.01.11.14.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:12:06 -0800 (PST)
Date:   Fri, 11 Jan 2019 16:12:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: add Plantower to the vendor prefixes
Message-ID: <20190111221205.GA29073@bogus>
References: <20190106171614.12615-1-tduszyns@gmail.com>
 <20190106171614.12615-3-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106171614.12615-3-tduszyns@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Jan 2019 18:16:13 +0100, Tomasz Duszynski wrote:
> Add Plantower to the vendor prefixes.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
