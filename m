Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeBTNlp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751738AbeBTNln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:41:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E42D21795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AH8x226vhxfewUrjnPWN/cJuOdkqGzGcqB6fMWHfoex1GTmtVOBraDdGPd64Kb3OZhICmD82buCHxHnIBbO1eQpv0TY=
MIME-Version: 1.0
In-Reply-To: <20180219133038.21995-2-ckeepax@opensource.cirrus.com>
References: <20180219133038.21995-1-ckeepax@opensource.cirrus.com> <20180219133038.21995-2-ckeepax@opensource.cirrus.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 20 Feb 2018 07:41:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLEhhe+sqtSTUWudNrSi9RnDEZ2nnQ6YViYELG+9KZspQ@mail.gmail.com>
Message-ID: <CAL_JsqLEhhe+sqtSTUWudNrSi9RnDEZ2nnQ6YViYELG+9KZspQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: arizona: Update DT doc to support more
 standard reset binding
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 7:30 AM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> Changes since v1:
>  - Drop vendor prefix from new binding since it is a standard property.
>
> Thanks,
> Charles
>
>  Documentation/devicetree/bindings/mfd/arizona.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
