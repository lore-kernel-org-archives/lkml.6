Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65373C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AF120861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="liOZBeTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfAUUUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:20:00 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39098 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfAUUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:20:00 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so24950261qtj.6;
        Mon, 21 Jan 2019 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43if8r5M69nq9nU35pg9/VrETmE3YFJtReqxfySrEgs=;
        b=liOZBeTNXsUGXXAwZLTa+zn5Ag1fhCr7DbCTDN9nJoaPE6l6xDLY4DSRW9pGTI+tF7
         hqgrcBg3n6MovV/8CIPUqQa5gjBoL9+bFPgbH8i5WZ2ZeTjhxShnUjd8V8m5abFtUBTe
         4zTZdh7cwUsZXL0I0coE4fq60TQ68UxpsFsQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43if8r5M69nq9nU35pg9/VrETmE3YFJtReqxfySrEgs=;
        b=B3T9LR6J3s3JzyC5ZJyAIcK1cWcIAW4xWloWeKVNuJ7VvF5tsvP/ymuN7RDjWcV21L
         efG7O+UIxIF+HKoYGxIFztlpU75iVzjSRbwEvif8B3wy6qUgvsST8zr/Y6XePEGwvlw9
         7h/UJ5L+fNrutzMwCclt7U+e12KTdh+0vAaWP1VwuoZFL6r1IPbjovfS1epHJlUC0NKK
         cSTV9ZOR0uM6nCnlQTQ2wMZHDky3WQ5RoPiYmqQq7BQuEQaFkrOrW3DBMcH32HEbvEAb
         S5AkK0W4nI76jGc1A8RYwAL6k+dI7dS8lK13J0oKU655ickd1+a7gcvb0wPuSY2cXtlS
         AnUw==
X-Gm-Message-State: AJcUukceuFLxkepZEAEbPv3Q+piKhWZ7LMr0QBBWsSJd4v/vh6H7ZwlD
        XWv6Z3uJQqY+lzowfCKlHyOGtan/592bnS4dX7A=
X-Google-Smtp-Source: ALg8bN4OzjwErcq0r7JEG0X1KaG/tKBbfNTWwOLfOCGWnSoR4CsAP4ExXwLmrjNBojP9/ZUX39ypCypJKgdkqgv6Q2Y=
X-Received: by 2002:a0c:89b4:: with SMTP id 49mr27070173qvr.85.1548101999151;
 Mon, 21 Jan 2019 12:19:59 -0800 (PST)
MIME-Version: 1.0
References: <1548100592-50383-1-git-send-email-eajames@linux.ibm.com> <1548100592-50383-2-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1548100592-50383-2-git-send-email-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 22 Jan 2019 07:19:46 +1100
Message-ID: <CACPK8XeRgCRmyFFxrwCGKnBm=+o=m_L6G=ZWftOV_QB7ATjxow@mail.gmail.com>
Subject: Re: [PATCH 1/2] hwmon (occ): Fix license headers
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 at 06:56, Eddie James <eajames@linux.ibm.com> wrote:

> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -1,4 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright IBM Corp 2019

We want to use the /* */ syntax for headers. Take a closer look at
Documentation/process/license-rules.rst:

2. Style:

   The SPDX license identifier is added in form of a comment.  The comment
   style depends on the file type::

      C source: // SPDX-License-Identifier: <SPDX License Expression>
      C header: /* SPDX-License-Identifier: <SPDX License Expression> */
