Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AH8x2263johA+5rMsqe07wPZALvcjd0pbGeYNbiuzlc6F30jBDAraOK03yTfm6ELg2SHFvHwAST7
ARC-Seal: i=1; a=rsa-sha256; t=1519192810; cv=none;
        d=google.com; s=arc-20160816;
        b=sWk5HQFICVnUJe5nrU1gS9gNA/E/fc+gccUQ8ziVO0mLL2jZfWIkdzi52j1Zz/MOKd
         WDLASX6TdJray/RGrgLXZpGc+grn8NJFNvFpd54H2bf26ZxqphqQ4tBeMe9sDhLbWemb
         C50O6QOIJzct2X1ZTx7EfpMwk2Qv7mGwtKHTGV/ql88UbPeNqsePrBpgIPlrip64KlIr
         KiI0DCdIg6PUlPEpqUdWzjDygNhsWzjTf4gZW5S2Fty2N5CoxuTKuKLCX+LQ/0Z1tdAC
         e0qtqvkrp+tndq3ksLiR7lnvDTAfkgP40F8nUR4T23NG3RcAaaf2WlksUwaSSxnnpToZ
         pzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=AsG2uHAxlzE/MvlC17ysE9/2pQFfGnK49y+SCsH+6LY=;
        b=aggDfrvIfm+S06+bpbW5jdsMCMbYn9HkILVxIkxGv4UbB8/9sd9vqVUim7R9dd6K/M
         cqZJJeh3nx01Qv9a3wp23Cptml7MQMeZIS3GxqcNpTG2TbtKjS6H47INmR3GZCUblumb
         B+G7jIPlEsj/twkFiRRnwOq6VCLgZMjJ7TO3iIZ9XYSKXiXhb4TVib+VlFDcJTihdIuR
         XBru5pgcN04GniNsJEu0XgWDr0U+s1PYjOe9RAlZuxBNRWRM2IaWXTh7ZmMmH7eQQZJR
         +Jnb6Ak2o+/fwIGb+9xlp4a9207k57S2xGxOZhTGI1Z0oo2JBEJSKXGibLSPrOo2zlVq
         q0iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to
 userspace
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        "Alastair D'Silva" <alastair@d-silva.org>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 21 Feb 2018 16:49:23 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221045736.7614-1-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022105-0020-0000-0000-000003F9E615
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022105-0021-0000-0000-0000428DF5B1
Message-Id: <e0b46de7-8b31-d0bd-63fc-4d10b1ccf31c@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210074
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1592989120475507657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21/02/18 15:57, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Some required information is not exposed to userspace currently (eg. the
> PASID), pass this information back, along with other information which
> is currently communicated via sysfs, which saves some parsing effort in
> userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Seems fine.

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
