Return-Path: <fbarrat@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZqMnmNLgUWqhDA+8hXdw+Zmzl6BSgSxEUP17z3ox1deZhpfvhtfMTeveuFgH+ik9YCS96mJ
ARC-Seal: i=1; a=rsa-sha256; t=1525716925; cv=none;
        d=google.com; s=arc-20160816;
        b=adYFg6KC2HrlPRAb20zbAZgFHiZqHZykazbbAjul0YNt86QkuONuaTVpJ17uQ8NEFS
         tws8amDQHaJyINUlDY3Xj7qILEtnITkBUAYz9uqu9oHvbFUWDJP7184OdAbhXiCmR2qL
         7BjXjqMXomml/+zItzKu9BAX9QRdYTPy96qN1/iTepQ67uvFtdbkGu9wg9QDapYQKhPy
         QgGaFgsl2IXbvKSJPopHGGyN1fdH3URXyi+JVx4HlCINIZkuQw49ky+9MzrnUiag6Fy2
         VvRGrNYBwexwqFoOCHIEK77AzkYgzJ1ANyujdDGvhCP+NeM/AFN4tB3vv/SU/XS2pbXR
         0Esw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=JyZLTmUi6TJVsw9cBqOBNkp0M7P8DJkq2pnXiIpm3Ls=;
        b=wa+w4wII86k+h24eMzX7MRnHY2B45NEUqx9ac/ftb9wQqVduOcktelPDzBE8PpKagc
         95/vrIMwnTCVipAgn6ZrgEB/ensHd9gZyp9qclFrEQzv+dC878DddNvuUDGv3lwC7HZz
         MVM/iiLiVpwfIC5MM1vBGwz6osXT81maC9hHV7430PpTkAxPEh3QZ5N0xJqZy1mIqaNu
         yNSHiorCA/pmL1UdS0qtec284q3qkomXEbwT9N2YQcE3rI95vzpvUPfQ+3gIZVsTm/OM
         YOBHc/rUhWEx4wOtV1kN++GDq+5iQDnQb4b4yLXvy5PTn0THh51LJTBW9uMqYI3WQPMT
         CqFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 7/7] ocxl: Document new OCXL IOCTLs
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-8-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 7 May 2018 20:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-8-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050718-0040-0000-0000-00000457003D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050718-0041-0000-0000-000020FB0032
Message-Id: <6c363687-531a-db76-2e94-382205dd89f0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070182
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957551491860164?=
X-GMAIL-MSGID: =?utf-8?q?1599830150830307431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred


>   Documentation/accelerators/ocxl.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/accelerators/ocxl.rst b/Documentation/accelerators/ocxl.rst
> index 7904adcc07fd..3b8d3b99795c 100644
> --- a/Documentation/accelerators/ocxl.rst
> +++ b/Documentation/accelerators/ocxl.rst
> @@ -157,6 +157,17 @@ OCXL_IOCTL_GET_METADATA:
>     Obtains configuration information from the card, such at the size of
>     MMIO areas, the AFU version, and the PASID for the current context.
> 
> +OCXL_IOCTL_ENABLE_P9_WAIT:
> +
> +  Allows the AFU to wake a userspace thread executing 'wait'. Returns
> +  information to userspace to allow it to configure the AFU. Note that
> +  this is only available on Power 9.
> +
> +OCXL_IOCTL_GET_FEATURES:
> +
> +  Reports on which CPU features that affect OpenCAPI are usable from
> +  userspace.
> +
>   mmap
>   ----
> 
