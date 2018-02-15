Return-Path: <martin.petersen@oracle.com>
X-Google-Smtp-Source: AH8x226FgQCAFyUg5G0XzisB5qbsVNT0ZmB79mydq6H18Htdl+CMroKzwdYfUENASoy16Bol3oCJ
ARC-Seal: i=1; a=rsa-sha256; t=1518738303; cv=none;
        d=google.com; s=arc-20160816;
        b=jn8KsiIKu5mUvGWVFuNRJ9tmDmk3ctomD4NM4I2bZWOtDP8P7CnS10MHexndk89b/F
         OKAIOMHdbeCe6vBaeh68YORBUQHsXt8YWmRriBxqL7K7uxL6BN+whSjmcxPiEWTgMAdM
         oIGWpJ+N0Jq6rnzzSsYUho2345W7E7E51VOtuusj0lREvujjdJCqqaMec1cyB1eo+oNG
         bc/tmEqqhknW40feecA1Vg5McSoAmB6/r7oDXz7/iPCmgaQDwyx6m240UX64UMmmBtIT
         HbDM2WHGMy1CnXb6LDH04yv0nhfbXWmCaI2sBNhV+1dnKJhwz1U2nIlS8eTIQWywt/ZW
         oiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:from:subject:cc:to:dkim-signature
         :arc-authentication-results;
        bh=tG+o5/7TetCHDYH91bXW0V2sIfTkGe+tltgJ1oJmHJk=;
        b=EzCQeHPNNB+b1QSS5pESe+Df8w3Ln7rBjfXx/fuo6JS3cjX76R7Y34jfPUvwg57RIg
         bWu1LEWfT4XpAJn2LuRifUUVCxjDYGbxNGPCjfCRQR1dUdI3Mq8e/SEoxtoswpOVdHQi
         CaxwxN/+cIcDE4nMS1xKZJeLtSIxBMD+05+VB7L8bEzvwvA3Xmj1XWeyj1OcTlewxkzH
         qk0Xp+siB67HapphMe9oEwJo5Wj/X7d8etY19EvL5SdNKNP4asuDqT81hLOY9C7Hogsi
         jo1LQY6jsw9kAxKxwdFprGK6B2AtbaAJSqmD/5tS7m2CT9yxA4bb1YaSrsXnds2Aq1V0
         v8YQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Zi/SdSXa;
       spf=pass (google.com: domain of martin.petersen@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=martin.petersen@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Zi/SdSXa;
       spf=pass (google.com: domain of martin.petersen@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=martin.petersen@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
To: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jaegeuk@kernel.org, Bart.VanAssche@wdc.com,
        alex.lemberg@wdc.com
Subject: Re: [PATCH v6 00/11] ufs: sysfs: read-only access to device
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
Date: Thu, 15 Feb 2018 18:44:56 -0500
In-Reply-To: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
	(Stanislav Nijnikov's message of "Thu, 15 Feb 2018 14:14:00 +0200")
Message-ID: <yq17erdlsw7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=549
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150281
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592469075953787501?=
X-GMAIL-MSGID: =?utf-8?q?1592512535505402971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Stanislav,

> This patch introduces sysfs entries that will provide read-only access to
> device management data that could be received with UFS query requests.
> User-space applications will be able to read UFS device descriptors,
> flags and attributes.

Applied to 4.17/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
