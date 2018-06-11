Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wmuuDfSRHls0EgAAmS7hNA
	; Mon, 11 Jun 2018 15:16:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D83EC607E4; Mon, 11 Jun 2018 15:16:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7491760541;
	Mon, 11 Jun 2018 15:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7491760541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeFKPQG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:16:06 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35840 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbeFKPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:16:05 -0400
Received: by mail-yw0-f193.google.com with SMTP id t198-v6so541946ywc.3;
        Mon, 11 Jun 2018 08:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jtU9gy+ZL5Db/rzXJtGjSUYCSm9VpQngroYjHwfX/6c=;
        b=jAoKBk7v225mdpIvfqHQWclxsu1e/wgHU1ZqIIzEyYSdMkw68kVYINqcHcXtAaqVYX
         GR4+vD/UzlCV1DXSetDcBjxPLyrEsfa6q0+X78+UngVO59wFT5/DRYKh9T4Ub6JSpKuK
         1rh1Bmid7Lplag3VJ9c8FfXsCZakg0cyJXk3X2e9jrXda0dbIuKBM9tIefBoi7Eyd1L+
         +ASFWw7E3Kz9CSUkzJIeOLPhj1EoO2SoWZTrQBZ6ShacRdeytCY75hmFU5oOXKNh6Hc0
         rJA+b3CKM4lralnj0Y+OzxEw6VTHnaCK/fE46SDuyd/trYF+etnr/IrD7x0/EZAq+6ya
         U1oQ==
X-Gm-Message-State: APt69E1Q3zyz0rX3MAqTbFjyZUbO0e9CKWWTQjKVRGqBg3OF+BcRsB1E
        HXmAu5xyZe0nIO7hAUDrJw==
X-Google-Smtp-Source: ADUXVKLC2rrTA2iB0qJHZ8Z3ggCOUYeU0RRO+FvjHjCvRfBY8SNrrJtt4uG2XCzTOmiDUWB64+O5mA==
X-Received: by 2002:a81:9fc3:: with SMTP id w186-v6mr1651686ywg.188.1528730164332;
        Mon, 11 Jun 2018 08:16:04 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p22-v6sm11676755ywp.105.2018.06.11.08.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 08:16:03 -0700 (PDT)
Date: Mon, 11 Jun 2018 09:16:01 -0600
From: Rob Herring <robh@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] Documentation: devicetree: tilcdc: fix spelling mistake
 "suppors" -> "supports"
Message-ID: <20180611151601.GA9300@rob-hp-laptop>
References: <20180606153942.18839-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606153942.18839-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 05:39:42PM +0200, Enric Balletbo i Serra wrote:
> Trivial fix to spelling mistake in tilcdc.txt devicetree documentation.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob
