Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753036AbeDLHTA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:19:00 -0400
Received: from cmta18.telus.net ([209.171.16.91]:34871 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752711AbeDLHSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:18:50 -0400
X-Authority-Analysis: v=2.2 cv=ebrSR/MH c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=Lx81O0FuHPcJw-QAFkYA:9 a=CjuIK1q_8ugA:10
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Yu Chen'" <yu.c.chen@intel.com>, "'Len Brown'" <lenb@kernel.org>
Cc: "'Rafael J Wysocki'" <rjw@rjwysocki.net>,
        "'Artem Bityutskiy'" <artem.bityutskiy@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: 6Cz1fQrxBvxoZ6Cz3fxUbk
In-Reply-To: 6Cz1fQrxBvxoZ6Cz3fxUbk
Subject: RE: [PATCH][v3] tools/power turbostat: if --max_loop, print for specific time of loops
Date: Thu, 12 Apr 2018 00:18:44 -0700
Message-ID: <003e01d3d22e$7faa6b80$7eff4280$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdPRf8krZa1XR4oWQrKzECmaX6DhVQArhF7w
X-CMAE-Envelope: MS4wfLpfIrufnmE4REeuJ3AoyTfPogOaNA6IYmiOqgAcnpbtcGlkM0YZ0vXMrOSysBx0gbPmVFqFA/Aw52X5wq9vILknDUndjQ6WmpibJy4N+oZaxG5B62K4
 fqtT/ScsypRLGuNGg0kDZLwQxCYZrwgjUOnDWJhkkBaT/TDNsFVca9K1xblgQhmUszeuqFUUw6k1pr2kcqPa0HEap7rXfxwd+pa4h5vJ1QY9KY7Y0LAKeCNf
 qhACn+jNHifhM2rByFnIZ7ITLVzVdnBNO1w4IsFJ5U0+HTBKQLawjE6p58AVRYb1kVbDYTUgS/Fge70QgDJPrE4nhK8EuCtxX25OO5rEGjmPvIkH8e1Mef4O
 Mg3gtETd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018.04.11 03:31 Yu Chen wrote: 

> From: Chen Yu <yu.c.chen@intel.com>
>
> There's a use case during test to only print specific round of loops
> if --iterations is specified, for example, with this patch applied:
>
> turbostat -i 5 -t 4
> will capture 4 samples with 5 seconds interval.

Hi Yu,

This would be a very useful addition to turbostat.
Please also update the man turbostat man page.

tools/power/x86/turbostat/turbostat.8

... Doug
