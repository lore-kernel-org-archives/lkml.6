Return-Path: <martin.petersen@oracle.com>
X-Google-Smtp-Source: AIpwx4913heoHoyeC6ZqZeTiyIhdghblvVu1y3jrh312U1/CYB5ck6pGhmmR6rcuqG5m+152IQ7z
ARC-Seal: i=1; a=rsa-sha256; t=1521681831; cv=none;
        d=google.com; s=arc-20160816;
        b=Iz4bPxsO/k1OvJr3MnzsNurVeZ5trF12IVc8Jo5kZFv/wawnQ4JIu2u1bQ91bQfW5h
         03qeEHAWAkGzs2qZpa32L/Z1bMTkXwTQYElnDF5oTF7/VBrynrXfah0y5AIejsG8LE1P
         g+L/rMfSnCKio9hfhFh6MzNU7Xc0Fe9klLLyQm6Z8Jwqdo8mwqJjxDpzpCw8ScEkp6KQ
         QyTfJB8yoRh93b/8Avw7BopJ/uIwNngDt2WWl481/FwYi0Kv1BcNaaICfeh/lnzAYoXV
         w1V0iy9S45fgUQiI6b4QUs2V5nTS6WiacWo/vUY/5YDlOu6+LJJIiQ4AqqwfH49bR+j1
         EZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :organization:from:subject:cc:to:dkim-signature
         :arc-authentication-results;
        bh=sQLUW1SPwT30MN0H6MFipG13/w0RV9XINX+r+TxoHac=;
        b=Uqs2VRr3+dqQXlSUaQIWsr6IE2vlrj1zleCqVxzNXJoTPcMN6WewImT/h9InknwD4w
         UALg0MnwvpjHbmqkkqN3YkRowaTOaMAvz+icdwk63sv7Y7ERdofJvkkJDS6E3+4Wfooj
         6S6iuFxI0KVkZ8D+K5wocp+myKsQY9OIJtAILbK14j8hiPs1pT5fw0oi4jRBbU1Gs+mz
         v42nKM/8t22FP8fdgguyWTn3/KXyl5Vd/pAbEW/JPQekAbgHjyG6wsQVk5VMfShqpvic
         AYwWQr6ov6O+7U0kOV+FgBQw0U6qBzDQQtBwawjKzDClrsrR5aUzhcft55Y56f8cTGcN
         Wx2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=jjcENbQo;
       spf=pass (google.com: domain of martin.petersen@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=martin.petersen@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=jjcENbQo;
       spf=pass (google.com: domain of martin.petersen@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=martin.petersen@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, subhashj@codeaurora.org,
        alex.lemberg@wdc.com
Subject: Re: [PATCH] scsi: ufs: sysfs: reworking of the rpm_lvl and spm_lvl entries
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1519901286-17496-1-git-send-email-stanislav.nijnikov@wdc.com>
	<1519901286-17496-2-git-send-email-stanislav.nijnikov@wdc.com>
	<fbea3b00-7497-cb3f-746f-65f793677568@intel.com>
Date: Wed, 21 Mar 2018 21:23:43 -0400
In-Reply-To: <fbea3b00-7497-cb3f-746f-65f793677568@intel.com> (Adrian Hunter's
	message of "Fri, 16 Mar 2018 16:19:08 +0200")
Message-ID: <yq14ll8rjhc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=694
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593732016815637504?=
X-GMAIL-MSGID: =?utf-8?q?1595599048562361472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Adrian,

> On 01/03/18 12:48, Stanislav Nijnikov wrote:
>> Read from these files will return the integed value of the chosen power
>> management level now. Separate entries were added to show the target
>> UFS device and UIC link states. The description of the possible power
>> managements levels was added to the ABI file. The on-write behaviour of
>> these entries wasn't changed.
>> 
>> Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied to 4.17/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
