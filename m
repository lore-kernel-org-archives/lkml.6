Return-Path: <robh+dt@kernel.org>
X-Google-Smtp-Source: AIpwx48kaWkNJc0g99eAbMyLh4Ny9OzK6KAFuOPhxg6rAFFkoOEXwHGq988+1hNNktFTgTyAV8+d
ARC-Seal: i=1; a=rsa-sha256; t=1524680821; cv=none;
        d=google.com; s=arc-20160816;
        b=UeFGwWLNDp+EjGkHs57uU76A6ZQnB0zFyGpgfW6rHn+civ8aykwLVa9vwGSEOcboRu
         QSuk3I77TgUCHgQOW8BPWl4fS0uOpGsk38oR6rykOFWaSW08lqYivqkRxrLEUaKzMgFj
         vlWnDls6hWKf5lYEdPOTlsBdJqfSDICCbrtF+zEZ95MF8a3gtJGxbh33OLzj8Dl7Zlyd
         qg44JRyfan2UMEOp5g2uCVpWezPJ2bGu8uMEJ8jhS3NBD68S2MSRIZszBcZAn5Cjz8/I
         fUZ6Eb9P/KTzOEy64F8AZguoNzmG0ICLGLXgrhZEj7Mj/QjrrBYiklxAs4CY4MufbkvW
         vstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=2jukO4Q1eCilnzNuRXp1jn5oeT52g1TKhKbh5tOCjVQ=;
        b=PMTraKPxPOD40JKlLlOCSQVr4xCYdxokEzUt9csw1G47oVayearHzH9XfTchKWbTvy
         pzuaVz3uKbxfCg0YTy+YX8f1nUuslKQo43rlWqman/y7qSGVQ4LwxyqbCL0kYsDGynjO
         Xcazm6sNL+CKUAlUxbpKjCvbJttdNB0wc7fJKErndNTYBy/wVJ95epliM/LSxZ4XYIeV
         s3kiuN9RnXHNRQaW9JnHFoGKozOfSAF5/DjTXX6L01sDlGZvUf+H00wPbIWPwokrfsl5
         KMxYFj+1Uqs5kroAypIyTnnv1tWKLJ4ZXALSa5t5MlBvr1oCTuLo+4QopiFTXskzqHzA
         IxCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE9E2183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180424163458.11947-3-johan@kernel.org>
References: <20180424163458.11947-1-johan@kernel.org> <20180424163458.11947-3-johan@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 25 Apr 2018 13:26:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+schVAhTcK1DJgLuk42c23Ti4jsefkO_whyg7CeoOwHQ@mail.gmail.com>
Message-ID: <CAL_Jsq+schVAhTcK1DJgLuk42c23Ti4jsefkO_whyg7CeoOwHQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: add generic gnss binding
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>, Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647062942889326?=
X-GMAIL-MSGID: =?utf-8?q?1598743716854323040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 11:34 AM, Johan Hovold <johan@kernel.org> wrote:
> Describe generic properties for GNSS receivers.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  .../devicetree/bindings/gnss/gnss.txt         | 36 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/gnss.txt

Reviewed-by: Rob Herring <robh@kernel.org>
