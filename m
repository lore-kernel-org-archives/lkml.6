Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeECRjH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:39:07 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeECRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:39:05 -0400
Date: Thu, 3 May 2018 19:38:39 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: linus.walleij@linaro.org, eric@anholt.net,
        Matheus Castello <matheus@castello.eng.br>
Cc: swarren@wwwdotorg.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1763017303.92936.1525369119182@email.1und1.de>
In-Reply-To: <1525135334-28506-2-git-send-email-matheus@castello.eng.br>
References: <1525030092-3643-3-git-send-email-matheus@castello.eng.br>
 <1525135334-28506-1-git-send-email-matheus@castello.eng.br>
 <1525135334-28506-2-git-send-email-matheus@castello.eng.br>
Subject: Re: [PATCH v7 2/3] pinctrl: bcm2835: Add support for generic
 pinctrl binding
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:Js4ufuZWJdvIhCED7/Ed0soF9E+1z+vXYDtlxQyqFd/orJCmLnF
 38wHUXhOuFyTKxVuJeH5ohQ4pSx3oXisvjgIAE24yjq9q/HV1otHjqju/FKkkCIjJDcF8uX
 UwQKfz/dqwcyLPgAT9OK1LvJG++9EXTaN1JbIPt5r+M7pfpbIe/5rDF4npZxYeQP9Ptx3Gi
 iOBo/gT5+lD+MC09w5jaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WL6LTjUxT5s=:gdWcblOjQ9+Ag3iZfXXwIQ
 Nbc7l+edPimI62jFcM2wc2ZHA5FBp55kSps0q1sXEabdA4cVvH+K6CzwA8N6/j3Opf47rHdyA
 vAKoEN5c75yKZWGcOj2IadFvTMTJfZrgy1MB/rfNZ24zwShHKUHyR5zN7Iyv8ydbFGYFpZid6
 si2Pdf7wD5GLJ1xwIkBFWjK2ttOs26wWBwEXqpAvmVJ2DN9wM9L3e3x8Wbfm0uMcY5BFQ4sVd
 MrvTrICfDMnY8v/31hsiEeynLyo1ODkO2SJCPoofPN6gIRTVOXm7Y3lilLMC8Ii/MfXd7cn4U
 RusLnHkNK6xQB6Pe+kdsgRMJEGRKbRybAdazuzKm5fGVN46uH31K35W2EIxWI3K9VQyMnMLyA
 vHl+8A3P6w4Rg+jQTCyxb0XOeF3Efhemabay/RF5p5Qwv2XpAakApIaSoIEJh/I0O3FTQbiJr
 +D2Z542wMVCe7l3wHs7WAlwANYSXI+TEJNv/6GC75BtRTtfbVuhjS7gZb4wsgDNk+SVq0CYMI
 NyRQCExNNJKgklwbv9cry2MRH0850yVtlu+DPXiEPu+u456OeHBL4q7AT5xIz15aHtIEZXfKk
 5g9+xXmWylfKEXwMN4IyMnhBv6VrHmGNwLN1jfnpPnNup+5XBAaCs17Kt/50fJmKupus/oux9
 5AxiM4XttBrSId6MJW80GieAO14tQInCoBDj1ebVAr2+F4QBwLQlmJoSnzQGlOPQ3diYyZCf/
 +CdrUztm/l/J8Pzw
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Matheus Castello <matheus@castello.eng.br> hat am 1. Mai 2018 um 02:42 geschrieben:
> 
> 
> To keep driver up to date we add generic pinctrl binding support, which
> covers the features used in this driver and has additional node properties
> that this SoC has compatibility, so enabling future implementations of
> these properties without the need to create new node properties in the
> device trees.
> 
> The logic of this change maintain the old brcm legacy binding support in
> order to keep the ABI stable.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Reviewed-by: Eric Anholt <eric@anholt.net>

Patches 2 and 3 are

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks
Stefan

Btw Stephen isn't BCM2835 maintainer anymore
