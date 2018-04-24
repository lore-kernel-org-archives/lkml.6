Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757812AbeDXNFP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:05:15 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33562 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbeDXNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:05:12 -0400
X-Google-Smtp-Source: AIpwx4/R/dl48doN9PCSvTJ5kO/sgYt6EjB5dvoagk9XY/2eQbAjyKA0zfrVlHZnAnSiF93l1gu8yw==
Date: Tue, 24 Apr 2018 08:05:10 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] doc: Add vendor prefix for Kaohsiung
Message-ID: <20180424130510.qdd3pmk6nzvkwojm@rob-hp-laptop>
References: <20180412143401.6433-1-lukma@denx.de>
 <20180417083115.11000-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417083115.11000-1-lukma@denx.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 10:31:15AM +0200, Lukasz Majewski wrote:
> The 'koe' entry has been added to vendor-prefixes.txt to indicate
> products from Kaohsiung Opto-Electronics Inc.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Replace 'kao' to 'koe' in commit message
> 
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied.

Rob
