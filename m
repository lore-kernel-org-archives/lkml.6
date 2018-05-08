Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755317AbeEHPn5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:43:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41876 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbeEHPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:43:55 -0400
X-Google-Smtp-Source: AB8JxZpZufD5Sald8y9i+9RlLJwNL05EyEz/CZ0Ro88M8puGi6wAFi1Q1LsSg7PvncKF6ErFXiVaaA==
Date: Tue, 8 May 2018 10:43:53 -0500
From: Rob Herring <robh@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        xiaotong.lu@spreadtrum.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Add SC27xx breathing light
 controller documentation
Message-ID: <20180508154353.GA28859@rob-hp-laptop>
References: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 01:39:44PM +0800, Baolin Wang wrote:
> This patch adds the binding documentation for Spreadtrum SC27xx series
> breathing light controller, which supports 3 outputs: red LED, green
> LED and blue LED.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - Change the compatible string to be one explicit SoC name.
>  - Change the child node name.
>  - Change to be upper case for the first character.
> ---
>  .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |   41 ++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
