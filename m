Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeBBJ4T (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 04:56:19 -0500
Received: from mout.web.de ([212.227.17.12]:57560 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeBBJ4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 04:56:12 -0500
Subject: Re: Adjustments for a lot of function implementations
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Jan Kara <jack@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Muralidharan Karicheri <mkaricheri@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <f9dc652b-4fca-37aa-0b72-8c9e6a828da9@users.sourceforge.net>
 <356f75b2-d303-7f10-b76c-95e2f686bd3c@xs4all.nl>
 <14619198-bebe-d215-5324-a14fbc2103fb@users.sourceforge.net>
 <alpine.DEB.2.20.1710301745530.2160@hadrien>
 <ebf37d57-38c6-b3de-5a66-dbb1c13fd63a@xs4all.nl>
 <049aa1b4-6291-ec24-1ffb-77ae8d1cdb63@users.sourceforge.net>
 <804550a6-1096-12f1-a0ec-1ccd6bcc191e@xs4all.nl>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f082b1ae-1be4-440a-6a81-68446c67243e@users.sourceforge.net>
Date: Fri, 2 Feb 2018 10:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <804550a6-1096-12f1-a0ec-1ccd6bcc191e@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:eGC8RrkmJERLhuN3CAi8O4ub5SENIJaI8ldQg7bMwV120uVgpX2
 g+e8HlJsU8PB1xZ9+u+xuestrto6EljwwwILbbJRGesATSNe0oqChJuztoWwEGlxxLNmfCN
 m3OcrU5P/B95G9dUEH1LnLH+3n0Plu/abrqbmgOb7ioBkBRbanPxWXQ3wg77xzCCdZb6EFk
 MNbGeTMoxdvyBQFp65RTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XU2ERFcQLco=:pwUMVnXeS+DUCU5wzxlpZ4
 S3LpKl4vMliEVKLVt3V/l4grqWh1lV0lQ6+9mZT/FFChYux7eNZ5IaZlC+8iZAZg7D26H5JSt
 I4ZaVVDcO0wwzRAMJHBJjWHBBPMS/xI6P7U41z+3aUj03p8IyG17Guuc5ekC8P+BU5LLf2a08
 XvWTBqijEpI1pXvRRPWjXb/xREXeeZF7pNvBgI5Go5pFVAsfl2JqN6qtBzcw52VealihNkCm0
 SxfwllJLDe+2JufSoAoz3yBLKBnGEFGr2C91Cn95GE54CmO7+zxe1oKKGXTIciGL3rFG6iRKG
 6TqVYuA2ewh/rA1vD2ftZvWkKd5b8TV99PQXXFigwSD6ZBl+Kv3GYhBcTa8uzGMryq0Y7AYj6
 xgrAhlUA3d9ylEFuf4k6Xvp144JNftV2JMEU7GjEgrdfWPqxjm+p19XwkCTR+FpCXtCCo/vUa
 IrRyVTTIomUClxfkS3J5PL2piZnE8vOTdWKKP15gNowJaETPeLeCmDtCvyieDumlp95tbiO91
 ZB2tFRk/78MV7T90zA6Jh6uuBYsCeK6BiO3fMgkWZd1CQmK5L/ffMaoaoXRrOS36zzX4OQa5C
 Nn/uuPE6bjCD1BdGPRKwLfAnZ9aIxTXFEHxmEsfXYtOTPbqI5GRRyNoVGWPuDb797no/Xm+5/
 Qrx5kDub83IJ/KEr8aEDMn3/6AjIe8oMqtpadOQn9sEQenQ105ZUQlBOQbuDF97u3QkTE1EDV
 /hbPdjR3ncJ8zg56oykRBrpt8O7yiHG9Y5e0fYwH32Bfpf2XL3gOBC2wRZuDi8zC5V8AnrrHY
 s5lmPRwQKHS+3FUhZW4443h9lnDEwPtOT7B6RrsZGA7M3ZhZKY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ??? I did that: either one patch per directory with the same type of change,
> or one patch per driver combining all the changes for that driver.

Do any contributors get into the mood to take another look at software updates
from my selection of change possibilities in a more constructive way?

Do you need any additional development resources?

Regards,
Markus
