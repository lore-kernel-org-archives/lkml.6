Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbeBSWJy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:09:54 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:34503 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbeBSWJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:09:52 -0500
X-Google-Smtp-Source: AH8x225Tjui/f9QKnUuZ/+fiA6F/cbEOrWMPfaczpHFQlYe1izzkQF5Fnrzki8pFV7pQ3G6FM7P5wdD2y4u/dvUU+WY=
MIME-Version: 1.0
In-Reply-To: <3eb514ff-d659-80ef-3e09-aa39c829f862@embeddedor.com>
References: <20180219171113.GA16636@embeddedgus> <87zi4428l7.fsf@suse.com> <3eb514ff-d659-80ef-3e09-aa39c829f862@embeddedor.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 19 Feb 2018 16:09:30 -0600
Message-ID: <CAH2r5mtQCyhfbFZ=Ux8Y3LQxDw=gZvfPy+xu3agF7g6fXthEmg@mail.gmail.com>
Subject: Re: [PATCH] CIFS: fix sha512 check in cifs_crypto_secmech_release
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Steve French <sfrench@samba.org>, CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1JM9wst032693

merged into cifs-2.6.git for-next

On Mon, Feb 19, 2018 at 12:13 PM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> Hi Aurélien,
>
> On 02/19/2018 11:27 AM, Aurélien Aptel wrote:
>>
>> "Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:
>>>
>>> It seems this is a copy-paste error and that the proper variable to use
>>> in this particular case is _sha512_ instead of _md5_.
>>
>>
>> *sigh* I re-read this a lot yet still missed it. Minor memory leak
>>   fixed, good coverity catch and thanks for the fix!
>>
>> Reviewed-by: Aurelien Aptel <aaptel@suse.com>
>>
>
> Glad to help. Thanks for the review.
>
> BTW I think this should be sent to stable too.
> --
> Gustavo
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Steve
