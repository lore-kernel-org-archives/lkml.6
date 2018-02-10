Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeBJUbc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 15:31:32 -0500
Received: from mout.web.de ([212.227.15.4]:47715 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeBJUba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 15:31:30 -0500
To: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] GPIO-Timberdale: Adjustments for timbgpio_probe()
Message-ID: <da77f86c-a366-0a0f-10fd-9b7cfd879391@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:oQ/unnknEw94vVhbRGoHxajnOI9eG66o7lHNTf2FrtWYmxnv3p1
 eknW9gJc8/0LpMwO9F9mWGHPgyO+B7nm/rDbOH0MWcLtoExnm5N/7PW7k03vNj4oHLAKQMI
 QzAZC1zVPbfh4Db3jyF5g6ELCEvhQU7nMLw8YiCGPdnqvET6wkZXruRA+xXfsjsVBzuL1LO
 jo8LkX4EMn2uHA0XPY8pQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cqjfyWlH2YE=:vWqOjZuW5TW9EH54NfUVd3
 4aVqKFw+aHDpDW3BEFCViYwSxUWCr3W6WLOr1c6MUKcTqTb3iaulSuFKlBtlAuEounR0NMeuR
 AkIb7NrSmMjCLrrssKscnoraMQqhs7+JF1UF5x092/CpIr/hQs7pJTFDuDhuvZrQgE/X/8hvU
 wPe7BlYH9shUNXXRrsDSvym9anZqTGz8wzCoTP7ojiTXE9u6CdotTaEjcUmaAG/RaEcR3Y2z3
 YsmlB3vFV82J+KX1XMwVXDLnuxw8DYZ2LGGldHdWo5iaBwBDDQ0zirzzBda3IZxPjE1IwqSzU
 5WksWaQf+tHy5kmM2U4r6qjIHkJ4P8hOiwoqQgWF/Bt/EcLCUCAY/EiWhq7yKSuIzLQ17CXF5
 joE85oD4bbMB0M0vrONRVirPwvzS0MV6RKrEit+c0vD5WZOcojcej/BhaZNmx+57VcY3hE3cf
 ZLjSJhedYQpMf6vCOHFjzTjACipEL665WftunKExAbGLykUTa09pIQfiUKXgpv0Y9t836Jb8M
 n0Zwt1vSnu3IuAOTqM4cW0u9vgGBJQ+/N0BLy8iuRvHq1gFq5TYJMPmSZx6xfkrQ+Dt3nI6IZ
 PPy/HILkCsky2NRIEIAWxPIWQ71Q5xY89DopIz2Jqd7WFH/7F7ybfNUytie6UIEtIy6AJoFfC
 N2x3Iy1IExnljwvdKxozGaQs9APzy7j97jZYASlmatPleu2pjCIFgHK/xk5pSAdGQr4jF+tn9
 43BeEb0jXHZdvnqyHpT8GBOrypBgJ1JqjdwtzDK444oMKKVWTdqjqrYejXH+7TISCItQaOC9c
 QTBVv4ag8oKFzMvmeJuojXwAEmvToTZ/pMG0rClbA/aA6lQjAY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:28:29 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/gpio/gpio-timberdale.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.16.1
