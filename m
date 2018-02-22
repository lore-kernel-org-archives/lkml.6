Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AH8x224LoitRokctykG0HLb0IvjzkaTwwx4f1DNLjeq6FMdFuDUwc2/x7VwObh3tRAp4WR0H1jHL
ARC-Seal: i=1; a=rsa-sha256; t=1519276917; cv=none;
        d=google.com; s=arc-20160816;
        b=TlRWoN2RbqGuDbr44SxTWfuWXMRUkb1WUYjg0kU2tOKz+G3mZoIAln/gEQuqscVdvW
         r/5TiDWjtaYWIJzVJzcGk7+2J0pBx6K5GJBk/YTDvurToZMdpQThCAejDUSjvlFysOE9
         W19al86a/8OMZcYTVa0Ny+ncYHRk4EzGzwSR2sTTCn0Zzsd2RlEj5wtqGTPD4Ds0cGQN
         T1MGfZzuvx25TQR8WRwHJgpDizxX5pr0sJJAjpnj8Ws9UsTgiDQLOphtDq0feYTVWbwP
         TQEk6LytZWd6jZt5ezIHqCIeYjF6BRDgXDU+sR2USK8cvNZQDQqKiiQ9VED9rciyyLoM
         hEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Nqp7phaRylSg0oisvCbgSUV07CEdAThKx+6YSIKSJIs=;
        b=VB0HTfcjStolNvyzPujcG46PEd4LROaQasHdVvYWOlN6DrTkXZ/WtizG+ZMnJo5Fkr
         ij4pGQLGyPYPzK0XWW8zv4LVKHvUBfcUBXrmLi1mHzujEPqtF3NZU6LJ5Ok7n8FHI1Z3
         v/zFSVvdvyyUpmvaU+FlJk344+SjQ7owRwHRicfeFSkU4QtaH3IaQrF0x5WrHbcdFoXP
         T43i1aKO2h39jR4gnD9mXenakL9fQ1qJtV7y3gQB2nfKY16aDrBpOdV0l78X7UBZHo0j
         SAE3JIREBxBUEL3sUi1lKHpJMKTd6/dHWPemUG1N51GDTZYX7FtCbaW/6bZMHnpeVSGV
         awvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 2/2] ocxl: Document the OCXL_IOCTL_GET_METADATA IOCTL
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        "Alastair D'Silva" <alastair@d-silva.org>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
 <20180222041739.27899-1-alastair@au1.ibm.com>
 <20180222041739.27899-3-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 16:21:48 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222041739.27899-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022205-0020-0000-0000-000003FA5C1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022205-0021-0000-0000-0000428E6F55
Message-Id: <8a3e5134-9d18-1060-c876-74bc625540dd@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220068
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593068678696230639?=
X-GMAIL-MSGID: =?utf-8?q?1593077312655820916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22/02/18 15:17, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
