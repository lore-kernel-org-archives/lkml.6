Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755961AbeEaRNK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:13:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39381 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755721AbeEaRNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:13:05 -0400
X-Google-Smtp-Source: ADUXVKJ5bK9bojCQM51IFHKzifJdrmRkD3hBja+qtl0t41avoAeWu3ANZFLvnsJuZ6/VKUe5szMtxQ==
Date: Thu, 31 May 2018 12:13:03 -0500
From: Rob Herring <robh@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH] dt-bindings: fsi-master-gpio: Document "no-gpio-delays"
 property
Message-ID: <20180531171303.GA12599@rob-hp-laptop>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
 <20180529013044.23815-6-benh@kernel.crashing.org>
 <1a2aaf52c2f4d948d55ccf3953db92528c296733.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2aaf52c2f4d948d55ccf3953db92528c296733.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:43:40AM +1000, Benjamin Herrenschmidt wrote:
> Support for this is being added to the driver but the original
> patch forgot to add this documentation.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Applied.

Rob
