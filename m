Return-Path: <fbarrat@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x225/TypPofT4KCj2oN4l8kxlp1IRH1pL30wHBo08NTCWWk0b1ffJefU8uHE2P3bdM+/Q3PQg
ARC-Seal: i=1; a=rsa-sha256; t=1519301805; cv=none;
        d=google.com; s=arc-20160816;
        b=Zr3mFXgU6/Qa8yag2DxW4FQA/4cjjS2I0JHu0sSCW3LYHhOOZMMNw0+anowjWxMGE/
         S6h1vmnchJ3RbtU/+A1t+ar3Fe8PYGi0+/cm8HDpwM2MeQs1xKbTKeCCQ3jdWujGy9au
         7C7y6Gj4OihvJ6bXIum3EUijxDvjCSun6dFOHw2a/FRkh93NCq59VD/mc03kBuqU0+Vq
         ZoCjxxFuF4giYNbpcs8kBH77z8VO4BE7ITvWOa10Cd4djs2oecSZa4gnvddJv0I4mo02
         8LUy16mfUVCjJikLKbStD7en4Iuf/Udke2b3H2CTnNbB8BpHxiqwQ59CdTaWmBPPW5f6
         PExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=7qEvscGs6jSvljtg5VdKb4MnJDAUuNz6YDWkZvvLE+M=;
        b=U2bHQq4AiMmcQJ3xKncNL5tmyJS+RaIkTdwOTiQ7DQ3ZxAsZ63OIg/SJkdBXCYAo6+
         dn5Bh6JQ5HA1uIgdpHY4BJDWwXLosQFYYTBlGPA3VpV72U5HBkdzObQ89pNh+ugnFj4G
         G4dRlHyPbrMTwzsPXgd1dUmj6Pwexmd9+JWwqpjZ4rc9hwxJQF5BWTPyKpMEtUJdcI7M
         deSNjeZpIRzrHc5hr2eL+EGbRxR38pdGCVt/qx7sKADXW7rk+30XjEwn5mULOzA7ArH7
         sry7Do+taJ1x975zQ+e0HFRchrv3KPnvdGG/utmXiGhBshZqriHp3ff6RFFswluqKVal
         KYBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 2/2] ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, frederic.barrat@fr.ibm.com, gregkh@linuxfoundation.org,
        andrew.donnellan@au1.ibm.com,
        "Alastair D'Silva" <alastair@d-silva.org>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
 <20180222041739.27899-1-alastair@au1.ibm.com>
 <20180222041739.27899-3-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 13:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222041739.27899-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18022212-0016-0000-0000-000005287EF8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022212-0017-0000-0000-0000286497DE
Message-Id: <7793f52d-23f5-27bc-37c4-232e569bbaa1@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220156
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593068678696230639?=
X-GMAIL-MSGID: =?utf-8?q?1593103409883625454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 22/02/2018 à 05:17, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---


Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>



>   Documentation/accelerators/ocxl.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index 4f7af841d935..ddcc58d01cfb 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -152,6 +152,11 @@ OCXL_IOCTL_IRQ_SET_FD:
>     Associate an event fd to an AFU interrupt so that the user process
>     can be notified when the AFU sends an interrupt.
> 
> +OCXL_IOCTL_GET_METADATA:
> +
> +  Obtains configuration information from the card, such at the size of
> +  MMIO areas, the AFU version, and the PASID for the current context.
> +
> 
>   mmap
>   ----
> 
