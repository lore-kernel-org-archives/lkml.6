Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeEaQuM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:50:12 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41981 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755687AbeEaQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:50:09 -0400
X-Google-Smtp-Source: ADUXVKLauI7m8wBev6DYvS3Pu0tUe2nvVHichsq89At4glX9yWIN5fgTda7G8R6rdhHz2PuXQPkIGA==
Date: Thu, 31 May 2018 11:50:07 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Remove obsolete insignal-boards.txt
Message-ID: <20180531165007.GA29098@rob-hp-laptop>
References: <20180528185310.21971-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528185310.21971-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 08:53:10PM +0200, Krzysztof Kozlowski wrote:
> The compatibles mentioned in insignal-boards.txt are already documented
> under devicetree/bindings/arm/samsung/samsung-boards.txt.  Also the
> contents of insignal-boards.txt is not accurate, e.g. does not mention
> Arndale boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/insignal-boards.txt | 8 --------
>  1 file changed, 8 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/insignal-boards.txt

Reviewd-by: Rob Herring <robh@kernel.org>
