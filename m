Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeCMI04 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:26:56 -0400
Received: from mout.web.de ([212.227.17.11]:46147 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbeCMI0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:26:54 -0400
Subject: Re: hwmon/sch5627: Use common error handling code in sch5627_probe()
To: Hans de Goede <hdegoede@redhat.com>, linux-hwmon@vger.kernel.org
Cc: =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <d08248a2-46d8-6f73-81f4-84ad21b7e640@users.sourceforge.net>
 <0cc0ab31-550b-fa34-aaa5-164f6ae7f7a9@redhat.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <17810b74-7b72-074e-5fef-b614fcfed738@users.sourceforge.net>
Date: Tue, 13 Mar 2018 09:25:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0cc0ab31-550b-fa34-aaa5-164f6ae7f7a9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:4+7zBlIgajLrHn8a+KjxHVXB2kLCQzWgz4JIahugKFqVxANA6tn
 Yl53a3KBZ8gAb2TTwVr3CPsBj3UguN33+2g5W2u6NyGpnbGLJohtWArHVNzM9hNEUOOfwR/
 bFqgJ7DG5QskcIgUl2Vu5vgli5pI1zraZytOKczXeGaiTJSdrmtikFGJPxzkaO6wZs+09c0
 cLcp78EAz+OJYpi8btg0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A9umjLhisjE=:alAaSAMJ35yLd0dp8vzuvE
 iVxZTZxnS/cyltjYAB31fU+a5ooBfjCmfrczSTbhFSodiIYs9ep7u07zdQn7db16TXB3ujWb2
 qCgv2BHP2AwyYhRQhAt/4xGUlCroTK+YWgQX/I/tZnHs37m61vV3nBpgn+28O/gvG3tzOmVKK
 6IoXBPVKLgqAqs/6AeIRDGvUOfEk3RQH8npjF9+sOTrSv5UtrNlCFbbjL2DxUumtKda7fj4JB
 FW+oKEf2ezy1i4gf2qXvzkeOcMrc61tYdyYHivjESWGtuHTYmsUZopwdKYcnCU7sTnEwzSmlU
 QVMSh5upFBaPQRgcwee9e+j7hGaMw8NQ5SvTeiBIU03dyQBLQnuIbEvWXmRxY5ZzHRvj3B9Be
 0TgCsJ/t32kOYMj+R+bhJbYrplW8PSVv3sB8rKtnOiXwAlLm/p23+SWPrGakaiH8agY+geKP2
 nzg+/mFAEqpzYj23kjFPt18nxW8hIbU/tH5KWxXqfkFmWjBrNElPK2SBq8G7WgNNxfHyogMCE
 YKAL7+kyThapD0MjXIttjDw+1yk9Z6D1p92FiK8Oy8eimsU4gFphdrHZ9vgCy5Xojx3WZRzSp
 bGwa/O6Eakygi4OZhTFI/OSTlPZWB6eZR4/WTXpOEgGuDc2xlN5WGOOd4mvEt+aglifCdmbhc
 HO0BD7HXGfPSX060wuxfMqldHCUQ5R1bqmlpNXVQM1R6U95Wo0kMTrUEmI01CEQwtes9iIOaK
 dTvvghALhQwB46XaCjiRIe/6gJDAUe1Hf3RPNRpNeaxKBkuKR+sFE9BGXqiLjEGBhbQMtmoOs
 nTiUNvyPik5megyKsvR+dney/Xs8m03AJTS2/2CakHN6fIOEok=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Adjust jump targets so that a bit of exception handling can be better
>> reused at the end of this function.
…
> goto-s going to a label calling another goto is completely unreadable.

I got an other software development view.


> I really do not see any reason for the proposed changes,

I suggest to look once more.


> they may remove a small amount of code duplication,

This was my software design goal in this case.


> but at a hugh cost wrt readability.

I proposed a different trade-off here.

Regards,
Markus
