Return-Path: <outreachy-kernel+bncBDX4F3XH2MMRB7HPX3KQKGQEKXP4J3Y@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1521465341; cv=pass;
        d=google.com; s=arc-20160816;
        b=wWErDjDoT6epJiC1qElAftoOQDpFSEMj10TqlKQHqcg7kX8WTj7dZGHlxZL1/BkFjT
         ULpRkn0piQSRJ5Jh+FLgfwYjDXrOMkS8g7VeTZk7SLMrf00ihaNBs5C+DFnK4QBXQz4m
         Gd2VHVy50en+27I8Y+Uzd82plU5bjnUGwMhKUub8yXA9LyWYma1ZDcTaql8Ny9TYh8xM
         lYuA5fowKk7DpxeNHONcuefkNLQ5ibNGOOOXJ9VI0vb0xOHWuhYaMbRJx4WWB9WHzbHQ
         z0nFnbsTFidE1lvFVcwPf5vHhETd/z8zeNdBeiDL6T3oGyBq8B57NSJJz8IrXO57KGmj
         tL7A==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:spamdiagnosticmetadata:spamdiagnosticoutput
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=X1bazBVw0dk4K9N+a3rxmOBP0qqz7OpoAZ7OM6K/52I=;
        b=oS5lrLNHkk4DCY0WK15bVZ7PrTKKktgf2ByZGw8we/QX1MG1LSIEDRTRd83d6O2YkS
         xeRMvPyP/NdCNru1kPICzx+uoFEO5K/5ntyhKCMttQjkh6Hg8URuD2yOlT1miM88rhYs
         pj99q6jnu1KRYeyDt53rXaw9+Cmln3KBDLwoiob09ng3dQjrycappNdkXoj/7q5dJDRm
         Ta+pDY63DQwKuogUKnkBkjlXCtV1zI/V1WRX8bu2WwS56Y07/Mk3ailcuiXgjPVIVuwP
         vA5aj5iYlMmohs/r5uoA2qZPtF+LIRxVXovLtNRet6fIudAAd1+vEPu2yTW7g+KcfSFE
         6F8Q==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=nyYg2rgk;
       arc=pass (i=2 dkim=pass dkdomain=amdcloud.onmicrosoft.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbdx4f3xh2mmrb7hpx3kqkgqekxp4j3y@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDX4F3XH2MMRB7HPX3KQKGQEKXP4J3Y@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=nyYg2rgk;
       arc=pass (i=2 dkim=pass dkdomain=amdcloud.onmicrosoft.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbdx4f3xh2mmrb7hpx3kqkgqekxp4j3y@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDX4F3XH2MMRB7HPX3KQKGQEKXP4J3Y@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1521465341; cv=pass;
        d=google.com; s=arc-20160816;
        b=U8Dj8UuYOl0DZ5IXRE2TtOk53KAQzWq9F7ScGXTui8FYL3o19fGw5xLmCbOF/tZYo4
         IqVQOlfLFLxYSUeejBUdJAuY1+jVKNtWgAIfHZ+scTd+x0lT3zUUg32RXnpvX3zJnbQj
         uM5QIwToQG4TFA5A5KsgEjicJPuexrB5lnNLGXQ1Ip3ggWpL81hSi3LiIu0cA4VI+KrS
         THdcceZIuWuF1rGh+Jms8czKxiCkL2uzRiVIVQArJDKHL9V4eM16qbbnV4MsYCkIdsS0
         GNiK5Gl82B3Y8Z6znmi2i4E3uKUxP42Fg+3YMIU7dOW5xOvT3gG0AkvZ1GCw+cxNdK/T
         TldA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:spamdiagnosticmetadata:spamdiagnosticoutput
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=X1bazBVw0dk4K9N+a3rxmOBP0qqz7OpoAZ7OM6K/52I=;
        b=EffQM4ubrPZ+SYz8l8K8aPsFFsREB3mQ59RugI55IEgHWhWJ23kPjeB0qfgU6UfM0L
         jN/xT5kSTctiPbalTRqgH9z2mOPy4bstC71D0JZPqmca3Ft+lzAZ1tkcODqhb7T7G0r+
         H3G2HlDrRpFQdQWIF8Q1iOBHLBK/Glz2YpwsGCJVmX36jubgKCbogRx98ZtyU/1HGvjK
         5j1/dZRdSHTFnD/EEvSyx9wc/hVCiyFvpyZRp99YUs7Z1DjPgoxKrbAipWjXLGBLST6w
         Ti1kdl2t76o1pWRF70nbolB8VUUAygN0X0MSWUYKGCoINDxIRx8CwkXitKTIV2H7wktx
         U+3Q==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Hbd6BLgt;
       spf=neutral (google.com: 104.47.37.85 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELs3WVl4pFizzbutfZxUQy28jGHOM/wbqkoxMNviEm4lQOiCioWk4lqEeLcbjJsPkWT0C1FbxA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1521465340; cv=none;
        d=google.com; s=arc-20160816;
        b=FZe8Gmcw753NXPPpJZHsNDivL7rTKkhzSROSGV8yhGoVtYrkSqqcEZzi2MNzEvl2Mp
         CGOEcKuCLj0UyTfcdF4bzx0KbJvh4EX7i/bnU4StpQY/yd9XdKdNAJ5lpTMyYS8z5VMZ
         YVHL9Q2Y5Wqc9qPup1KBsQbStSeYF5apukJ1vENlTMVXYhDE9n7cQkISkulcEVwsIoTv
         WRE2+aY5tBzNhTDC7J98PgKww7Tp2HBKYPs2RDmNO9bMNHsY+sqGV+RqfhQCuT+aWhJG
         EwTxe6m7LgHCfbvZzjkPPDNnguMdfdzDvzlxqat+s7XDJwaHjRzFmDxZYVYTHPrG7hFl
         cclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:dkim-signature:arc-authentication-results;
        bh=EjipgeFm02x63nFTb1ng5nG+URvz3K0kxBoHgxLjSnw=;
        b=iL9xv/824D8rK3uvS/QxpgDr1Af015Tns5JhmqQbVjf3r8GIFTAZpJXXjBVfipe1Dz
         7FyeZJJTzM+fMDt1/Y0tVCeDnXGB2HoTO/TcIMZ7QVnTU7xPoUTt/Fry0WKtz5+Mi80K
         v2qVedTBDOrVcbe3eSAHIAcfenJUftnKQuv+jeeZvJoWVZAi2IQYu5QiHPuGcaKmrtLu
         Jk+vXWTBSbqD9SkXpcf9R3RpP9NF5RX03d1bonHM4rdeSqsEXqSZ+VxJnNvPMwJbvvMY
         xoHBMi/pDwPZJ30ocd+1IN4P8G542uyahB4UuI1fAH0ELtNh3SvFb8tk3zEb3RjfeIHw
         OXYg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=Hbd6BLgt;
       spf=neutral (google.com: 104.47.37.85 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Subject: Re: [Outreachy kernel] Re: [PATCH] gpu: drm: Use list_first_entry
 instead of list_entry
To: Julia Lawall <julia.lawall@lip6.fr>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, outreachy-kernel@googlegroups.com,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20180318215105.GA15431@seema-Inspiron-15-3567>
 <8b1e22f8-7a05-b66b-8825-7d4d97e46dac@amd.com>
 <alpine.DEB.2.20.1803191204550.3392@hadrien>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dfc1bc65-d6c0-8935-e787-4743d3cdabae@amd.com>
Date: Mon, 19 Mar 2018 14:15:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803191204550.3392@hadrien>
Content-Type: multipart/alternative;
 boundary="------------6CE5DA37F03A48653B7B4E05"
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: HE1PR0402CA0026.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::15) To MWHPR12MB1727.namprd12.prod.outlook.com
 (2603:10b6:300:112::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 216fa055-e3e4-4d13-2dce-08d58d9b815e
X-Microsoft-Antispam: UriScan:(215639381216008);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1727;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;3:E/lp1qsAE06MLoVFZjZBELD74aPAdq3y6B17vcjaCzn8kQSaBskpqmDXimEwOD+RNZfn2vySWD3WtpWKDUZVXnHC0ZL5ekFxfJjWlOmBu81VbZfXYLNIPBOTwPX3Bw84zMejGE6OTqUNS4rZF1Gs2KKv86CJlb+clcBrinwI9NSM1ou8fslHzVzIVn6O4AAP2VUkS46F8QtZBgbngbNgF7Ny06r5znmZYhPhS1Hcbx7yNDnAohfJJW458upXo251gwf8KcuJ2pgV7daoEQmGcXphgWRxoQY3ntKg8OkdMRc=;25:LlKbEbrWD1Jdh8eiPSWonLmZsiVYnEq2NrlkLrBrriMUb4aTK0EXJ7LS9mpLABgdqpO0mZ8k0itsezuLUsHEsAg76aPE4Ct0e2aIRj0ZNNB+lYc4nbs+YdTcNzhDNoL/Noqh/c2adb9dQdkUiwWoirZW6RnRXhfWVyk6+d9+CUp7JiwZEhqtnJS5hebTrjRw0LXm/sO52SppY5LL918WPpoGlfEiu+V2n08EuelEywZjApAVYJRG/2Jj4g/+6XcvbvhcXa8PFQuGxP51qRuvb8jYRb9i5EEO7NVYDW1tSsIJdpf0mjX6UDZUGguzNjgawaYGX2/Kn5qOgh+4oa41Sw==;31:VPrcq7QCrIPCtC9CGcBKOZmxE0GY2qpmtmJyZecefQ50LCRhJXt63WVQON1sNGbuclOMheWW7O5QaYYsNupjM04Aupob+EdMYM9BHQ4s3S3t6UiLC3uSlFmgO1WTD2DkrJgN7+6CymewJwDabPdu3BC5muGVKbuIaV2/xvDyYl92/6OFFJ+DDxWotepRWuUwzlqCliVDZTYNJU3RMtgU3xhlaqfQdiD8EY60bVNHMlw=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1727:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;20:acVzB5Rhd8cWYUkBn97M9zUaQi/W2GIrAUsgeIk0uZDNKH/eVkoq1GlcthFuvAmpNZMSFeZ2lc7p8yTqsCqdeGa1sqFj4DSmlmVkQ0oQBaBMlbXPrslw1Kgb3BptcbFyIjkY5SyjRdbeSXRUAlR+1xrTtmrV5g0vtKDuhrkWzbLUz9McD5PzvgrtOxBhpsBxnK3c8dlGH+quQL3M3FI+tBEqbv6i3RqZYTDtWS8v2WItcIp964DbmEoeBROMYdy8fd5vsOc81Lt+scVyhM7v/O0reMrtEMW7IOrmxeREkTLOTqON/lhnSTEqVA3IBcAnrr+FA+Jzngg1k1igUW5e48SCblQ/xkAFdW4TbwIPboyTF7jvLp+HAfooh3+cxgo7DMTxXND+Ey2AjqTjSbUbCw/bSRBph633tIYqRD8x1nB3A/yFr3pPp68MJBX5OfQKu1z+YLOEfIwl8CtXf3FN1Jgen7DKfTvjlPjChtdRWH8mJFMrxPHm4FXE3+a9rM8m
X-Microsoft-Antispam-PRVS: <MWHPR12MB1727AF6ACF340DE59DF6079C83D40@MWHPR12MB1727.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(215639381216008)(228788266533470)(85827821059158)(211936372134217)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1727;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1727;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;4:Q3meJ4h+75lBENoQus0SzP9loXR672+d+rjI5RjwV3YV8EiCXA5h2qPPncfdb4cYiVEHBs9XoNSLMI/FJF2t4YwOOtz+nvTawXpyligIfruPu7uO/rt3adeBRjN6tocr1spOXDAwquLXJWyQfHZSyhRtXoo4H1UPK5KMmyZ1GIIzXw1RrdNY++xniR8IAJb5v+xhIBLGeFGqb8E/q3fa15VM+QuRkYj7BYAOc1UrppRcriCU+eIdB1JOrcimUqlTG+RjKCD7qrix4JO1S2169dUXYxiyGrG1XsObamhy+WKGa3uX1SPGMUeEhQwMjBCB8rfVrI0vAz53NpXj48bgTpjxN5hk88KYNfqx5ydrmwux6D9zum9xERZ5fa88M5r/MYQ/OC0j4C3843Wn7P7jEEKM3QW/DjPU6IKVwOLLN8Z5tNNRJEZCvudJTFw4EML7+J58ez2gGn6i8JC+j/2Gzg==
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(346002)(39860400002)(376002)(199004)(189003)(64126003)(36756003)(6486002)(31696002)(86362001)(5660300001)(39060400002)(16526019)(65826007)(97736004)(6666003)(2906002)(606006)(68736007)(84326002)(386003)(7736002)(2950100002)(65956001)(65806001)(33964004)(25786009)(46003)(4326008)(76176011)(478600001)(16586007)(58126008)(37036004)(8936002)(52396003)(52116002)(81156014)(81166006)(236005)(31686004)(1706002)(6116002)(6306002)(54896002)(53936002)(966005)(110136005)(106356001)(6246003)(229853002)(54906003)(72206003)(316002)(105586002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1727;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1727;23:bOQUr2sKl/Zi9eBpUF8Wow93ylye2wLheoRZ4NduH?=
 =?us-ascii?Q?RiVwuCxBanDyOFCmk8itWeiWor6pO43Rc+z4AEVs6cYWeaj3r3FjVVVrbDk7?=
 =?us-ascii?Q?IrEmqvgJTl7L4YHjbDwk5XJHKWm0nPcKUFsZpDJTg09sgiH3M4wxyBu4U0QG?=
 =?us-ascii?Q?yu6IzD8jYHfUObrZaI8yrJX+41HVZ2tzx7xtn7vBkbq564WzCu7uygElwvE5?=
 =?us-ascii?Q?4AlMU8oh35W7b9x+TGeVp8xjlMU0FVwvcjOFW/mbbrmT1i11FdZvHw3D90Yw?=
 =?us-ascii?Q?ahEPMx+BkOze7AOOy7Gy1Mcv6tNACIYvav7i6uX+vB+DSE8wsFxrp+WePGT7?=
 =?us-ascii?Q?COfp2x1r8MhZF1tQRsMlCy256TV/8nELTUGfkvXhLAHktbo6qUNS8L5iBNH3?=
 =?us-ascii?Q?+hId8qWx9pulaEPVa6jyLEWz4ZJNkPL9jT4EQx1MH2CKNV7KZhM3Of6lzjog?=
 =?us-ascii?Q?I9dBbLhxFJDMtqbSXQpcDpJ5xV22tTo+BW4uAtq2rn1h3YpXT6+SnQicda7R?=
 =?us-ascii?Q?OddXd4bvE2nCvLt/g0uTo4pKCo5Z9+z0WrO/DS0OFnQu3hEwJcGiHAwCViMW?=
 =?us-ascii?Q?KA2wQk97JCGSqpdLaB311hAwdUoBHfJl0yUUJvuzfe/OThhkKnt9iphSk0f0?=
 =?us-ascii?Q?IGVUCuwDGYIgm62zNbW7JjGyyAzCpXAjxUzhOJHSSoL1iqdaegkfTosShq68?=
 =?us-ascii?Q?XCyQzucCgOrQ497t7uwGU84FDM8T5YW5CkudTp7/A9tLeKII5+KJQ+DGoSW0?=
 =?us-ascii?Q?DpicByiWJ7HTtvuLpe7SFAbNvA5BwTy+Pjs60FcsQwc9N/NGKGvPi/w3uZIL?=
 =?us-ascii?Q?NkYSzcwOu9NzdzR9FRmsK7Q5Ge5KSbLwCMoR+QHltOK3QX71A2oo5rWqPUy/?=
 =?us-ascii?Q?zDKcfbDQ45wjXx008qAAKSKEsDz6tIp7cUG3Pv3bGzJ+SYibshX6FXX4RHMk?=
 =?us-ascii?Q?8d22GcWqthDEiw9DjTDJNPcvqZeAc4aQcB0FQrTYegPR/eYJS6EipNem7Fi7?=
 =?us-ascii?Q?IvTBIvUNY2cGbpsNavmYtU05vCgnZ5ufzCj6AJRIi5ddk5cLTTSR6YvXhYGq?=
 =?us-ascii?Q?UUdh32TejBcaeGkBOOcNMtZTbLRz8q+WcuK8d/oNBEsCVsLELIcD6RAD97pw?=
 =?us-ascii?Q?CsQBSgzuC3B7JDySxFm8uOKpmZY2WBkDJIjiKiu40zMEhfrv0l4REbwsdhys?=
 =?us-ascii?Q?PzyiDPtgKWgzve4M2Fh7Npzff8wvXHO+WyISbcBnceBOHE05vzwcKy7ftvlY?=
 =?us-ascii?Q?nhFgndTzv0uZiD1udAkdDQsVarPxpzEaDGmyvp1/wBv3C1AD5ze9t0oKnbkZ?=
 =?us-ascii?Q?ghFKHeh4xtpldLdxXIY5mni1zIREWWz4rHqeMFi7Z5U?=
X-Microsoft-Antispam-Message-Info: 0rrOS3OoaMkKVO9MmPKHjZIo2lMhVh94IssZsojDkz38Y+wP69qxSwmpWwLm1alvoK0Ufi0RHzK+Qitrpcd5N+rB0XXptp3aE+3kaYfv9gETuUtoSKIXqLX+3HARJNpLgi+00YjJ4Rx1zpS4pK8ZaplBXd7dXDdSM5h5a41rIQ9pOC3GJnBAoN/PM5Lqyp/o
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;6:g7C5Av+8EL+dPoqPKZtBq2NoQQ7b9jic+Mt4mGnGSlT+3lltffoOZdhCeZricTVEQAXxARwT2zDs24cAMvbJEXzEXxV4vmmlqUtpNwKvdlMQN7IEJ7pjFHaRfHUDrr+IVOGIOuKlo2dygzBZj4BJMFtgFWFN31AU92RhOWfQ3vYSDfZiNzdGvGZXckX35jVd3e7wSAJtEWgiNOoM1PSGLew2tN26B2PniCoLZEabOnbUzbeKAfMJgUMYoETeL23YGD1bu/u5XJJMPboXST7Ns3qW9sjpsnTmMlcsEwAakjQ/8EprIq8F5W4EqE61My6DYugPijJcVXRaPTe9xbb0UVb+VSNp5v4GDk5sVyXtbBw=;5:fI5/Fs1ISbf2Ke1h8HF7ESdbmLTRrPL5BKeVkPblsdSbiXDSmgWTULrOcQrpq+wNxqdDsT95m8J4XtsyrK2ExbDSExJdWzggT349rIv0BP3cCcYwwKyDf+eNUnyjRUVUsD20PA1e4xWqQlE+i730cUBG1ZEj5DHWX0SoauFST3M=;24:4p1TZUEYsixz9rOnIT7nT6E0a5zVHNHii42i0OTmUwhVFEWqfm2N3ArkHqKwLXWuW6aXGpcAhJU1jvYwK4nKE7rScI4yv6k7CvhZnPnW8D8=;7:Sv+1OXcDbNsSL81zQPEh93aiyzF6ZKIyzKuroLbAnYE69+wuLNPqliIBClQ9bbx0dgc5gAh/dfuc6YKyyLlipxSnjbl7IxENiK7FcBZfgj0Sr4a1SEz+TwSDAOPM5t7wH6ZqmzLsbQBb1PrKd4mGW5sTVYLOaIZL+FntGoa9llqvAcMLdE/A91iMybG2Gd51cCJPEfN3MRnTE3IWEycR5NYgfRJE/nWwyICvalcKzyKj0dejyFCyDRAOOyGCq5eJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1727;20:0FQYRPGbLtv+F5qswEbd5LivTurn/dZhdtNyZjvoZOkrifxr/8H5zeqjlAIMmrzlnvuJ/0lwP5UVWbQIA3o2HcpfwhI2ow5T8b+ZT6cmFmzIUE7Z4QqNq/wlMMam0ttiO1spJI1EwOIeYaz3UHL8l+pwYPrVtMegJNKfzc7KItgwVjsFLJurRepYKS+WVu061nUExIoJGkZlhTpDljbKjZVk1rXsTv4T1qyAjmZw7Jv7wXw57a9yU97NBTTp8WXi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 13:15:34.2676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216fa055-e3e4-4d13-2dce-08d58d9b815e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1727
X-Original-Sender: christian.koenig@amd.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com
 header.b=Hbd6BLgt;       spf=neutral (google.com: 104.47.37.85 is neither
 permitted nor denied by best guess record for domain of christian.koenig@amd.com)
 smtp.mailfrom=Christian.Koenig@amd.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595313921234886794?=
X-GMAIL-MSGID: =?utf-8?q?1595372041979070186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------6CE5DA37F03A48653B7B4E05
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Am 19.03.2018 um 12:06 schrieb Julia Lawall:
>
> On Mon, 19 Mar 2018, Christian K=C3=B6nig wrote:
>
>> Mhm, actually that patch isn't correct. What we grab get here is the nex=
t
>> entry, not the first one.
>>
>> We don't have an alias list_next_entry for list_first_entry?
> As compared to the semantic patch I proposed earlier today, it would seem
> that list_first_entry is useful when the types are different?  One would
> have to check the result of course, but a list eleemnt with the same type
> as the structure that contains the list might be unlikely?

The list element and the list head have different types in this case:
>    	if (sa_manager->hole->next =3D=3D &sa_manager->olist)
>    		return;
>    -	sa_bo =3D list_entry(sa_manager->hole->next, struct amdgpu_sa_bo, ol=
ist);
> +	sa_bo =3D list_first_entry(sa_manager->hole, struct amdgpu_sa_bo, olist=
);

sa_manager->olist is the head of the list and sa_manager->hole can point=20
to both the head and any element in the list.

The statement "if (sa_manager->hole->next =3D=3D &sa_manager->olist)" now=
=20
checks if the next pointer points to the head and if so aborts the function=
.

Then the statement "sa_bo =3D list_entry(sa_manager->hole->next, struct=20
amdgpu_sa_bo, olist);" returns the next element after the hole to try to=20
release it.

So with the automated change the code is still correct, but NOT easier=20
to understand because we actually don't grab the first element here.

Regards,
Christian.

>
> julia
>
>> Regards,
>> Christian.
>>
>> Am 18.03.2018 um 22:51 schrieb Arushi Singhal:
>>> This patch replaces list_entry with list_first_entry as it makes the
>>> code more clear.
>>> Done using coccinelle:
>>>
>>> @@
>>> expression e;
>>> @@
>>> (
>>> - list_entry(e->next,
>>> + list_first_entry(e,
>>>     ...)
>>> |
>>> - list_entry(e->prev,
>>> + list_last_entry(e,
>>>     ...)
>>> )
>>>
>>> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 4 ++--
>>>    drivers/gpu/drm/omapdrm/dss/display.c  | 4 ++--
>>>    drivers/gpu/drm/radeon/radeon_sa.c     | 4 ++--
>>>    3 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> index 3144400..646f593 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> @@ -158,7 +158,7 @@ static void amdgpu_sa_bo_try_free(struct
>>> amdgpu_sa_manager *sa_manager)
>>>    	if (sa_manager->hole->next =3D=3D &sa_manager->olist)
>>>    		return;
>>>    -	sa_bo =3D list_entry(sa_manager->hole->next, struct amdgpu_sa_bo,
>>> olist);
>>> +	sa_bo =3D list_first_entry(sa_manager->hole, struct amdgpu_sa_bo,
>>> olist);
>>>    	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist=
) {
>>>    		if (sa_bo->fence =3D=3D NULL ||
>>>    		    !dma_fence_is_signaled(sa_bo->fence)) {
>>> @@ -183,7 +183,7 @@ static inline unsigned amdgpu_sa_bo_hole_eoffset(st=
ruct
>>> amdgpu_sa_manager *sa_ma
>>>    	struct list_head *hole =3D sa_manager->hole;
>>>      	if (hole->next !=3D &sa_manager->olist) {
>>> -		return list_entry(hole->next, struct amdgpu_sa_bo,
>>> olist)->soffset;
>>> +		return list_first_entry(hole, struct amdgpu_sa_bo,
>>> olist)->soffset;
>>>    	}
>>>    	return sa_manager->size;
>>>    }
>>> diff --git a/drivers/gpu/drm/omapdrm/dss/display.c
>>> b/drivers/gpu/drm/omapdrm/dss/display.c
>>> index 0c9480b..fb9ecae 100644
>>> --- a/drivers/gpu/drm/omapdrm/dss/display.c
>>> +++ b/drivers/gpu/drm/omapdrm/dss/display.c
>>> @@ -158,8 +158,8 @@ struct omap_dss_device *omap_dss_get_next_device(st=
ruct
>>> omap_dss_device *from)
>>>    				goto out;
>>>    			}
>>>    -			dssdev =3D list_entry(l->next, struct omap_dss_device,
>>> -					panel_list);
>>> +			dssdev =3D list_first_entry(l, struct omap_dss_device,
>>> +						  panel_list);
>>>    			omap_dss_get_device(dssdev);
>>>    			goto out;
>>>    		}
>>> diff --git a/drivers/gpu/drm/radeon/radeon_sa.c
>>> b/drivers/gpu/drm/radeon/radeon_sa.c
>>> index 197b157..66c0482 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_sa.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_sa.c
>>> @@ -158,7 +158,7 @@ static void radeon_sa_bo_try_free(struct
>>> radeon_sa_manager *sa_manager)
>>>    	if (sa_manager->hole->next =3D=3D &sa_manager->olist)
>>>    		return;
>>>    -	sa_bo =3D list_entry(sa_manager->hole->next, struct radeon_sa_bo,
>>> olist);
>>> +	sa_bo =3D list_first_entry(sa_manager->hole, struct radeon_sa_bo,
>>> olist);
>>>    	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist=
) {
>>>    		if (sa_bo->fence =3D=3D NULL ||
>>> !radeon_fence_signaled(sa_bo->fence)) {
>>>    			return;
>>> @@ -182,7 +182,7 @@ static inline unsigned radeon_sa_bo_hole_eoffset(st=
ruct
>>> radeon_sa_manager *sa_ma
>>>    	struct list_head *hole =3D sa_manager->hole;
>>>      	if (hole->next !=3D &sa_manager->olist) {
>>> -		return list_entry(hole->next, struct radeon_sa_bo,
>>> olist)->soffset;
>>> +		return list_first_entry(hole, struct radeon_sa_bo,
>>> olist)->soffset;
>>>    	}
>>>    	return sa_manager->size;
>>>    }
>> --
>> You received this message because you are subscribed to the Google Group=
s
>> "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n
>> email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/outreachy-kernel/8b1e22f8-7a05-b66b-88=
25-7d4d97e46dac%40amd.com.
>> For more options, visit https://groups.google.com/d/optout.
> >
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/dfc1bc65-d6c0-8935-e787-4743d3cdabae%40amd.com.
For more options, visit https://groups.google.com/d/optout.

--------------6CE5DA37F03A48653B7B4E05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Am 19.03.2018 um 12:06 schrieb Julia
      Lawall:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:alpine.DEB.2.20.1803191204550.3392@hadrien">
      <pre wrap=3D"">

On Mon, 19 Mar 2018, Christian K=C3=B6nig wrote:

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Mhm, actually that patch isn't correct. What we grab=
 get here is the next
entry, not the first one.

We don't have an alias list_next_entry for list_first_entry?
</pre>
      </blockquote>
      <pre wrap=3D"">
As compared to the semantic patch I proposed earlier today, it would seem
that list_first_entry is useful when the types are different?  One would
have to check the result of course, but a list eleemnt with the same type
as the structure that contains the list might be unlikely?</pre>
    </blockquote>
    <br>
    The list element and the list head have different types in this
    case:<br>
    <blockquote type=3D"cite">
      <pre wrap=3D"">  	if (sa_manager-&gt;hole-&gt;next =3D=3D &amp;sa_man=
ager-&gt;olist)
  		return;
  -	sa_bo =3D list_entry(sa_manager-&gt;hole-&gt;next, struct amdgpu_sa_bo,=
 olist);
+	sa_bo =3D list_first_entry(sa_manager-&gt;hole, struct amdgpu_sa_bo, olis=
t);</pre>
    </blockquote>
    <br>
    sa_manager-&gt;olist is the head of the list and sa_manager-&gt;hole
    can point to both the head and any element in the list.<br>
    <br>
    The statement "if (sa_manager-&gt;hole-&gt;next =3D=3D
    &amp;sa_manager-&gt;olist)" now checks if the next pointer points to
    the head and if so aborts the function.<br>
    <br>
    Then the statement "sa_bo =3D list_entry(sa_manager-&gt;hole-&gt;next,
    struct amdgpu_sa_bo, olist);" returns the next element after the
    hole to try to release it.<br>
    <br>
    So with the automated change the code is still correct, but NOT
    easier to understand because we actually don't grab the first
    element here.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite"
      cite=3D"mid:alpine.DEB.2.20.1803191204550.3392@hadrien">
      <pre wrap=3D"">

julia

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">
Regards,
Christian.

Am 18.03.2018 um 22:51 schrieb Arushi Singhal:
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">This patch replaces list_entry with list_first_ent=
ry as it makes the
code more clear.
Done using coccinelle:

@@
expression e;
@@
(
- list_entry(e-&gt;next,
+ list_first_entry(e,
   ...)
|
- list_entry(e-&gt;prev,
+ list_last_entry(e,
   ...)
)

Signed-off-by: Arushi Singhal <a class=3D"moz-txt-link-rfc2396E" href=3D"ma=
ilto:arushisinghal19971997@gmail.com">&lt;arushisinghal19971997@gmail.com&g=
t;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 4 ++--
  drivers/gpu/drm/omapdrm/dss/display.c  | 4 ++--
  drivers/gpu/drm/radeon/radeon_sa.c     | 4 ++--
  3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 3144400..646f593 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -158,7 +158,7 @@ static void amdgpu_sa_bo_try_free(struct
amdgpu_sa_manager *sa_manager)
  	if (sa_manager-&gt;hole-&gt;next =3D=3D &amp;sa_manager-&gt;olist)
  		return;
  -	sa_bo =3D list_entry(sa_manager-&gt;hole-&gt;next, struct amdgpu_sa_bo,
olist);
+	sa_bo =3D list_first_entry(sa_manager-&gt;hole, struct amdgpu_sa_bo,
olist);
  	list_for_each_entry_safe_from(sa_bo, tmp, &amp;sa_manager-&gt;olist, oli=
st) {
  		if (sa_bo-&gt;fence =3D=3D NULL ||
  		    !dma_fence_is_signaled(sa_bo-&gt;fence)) {
@@ -183,7 +183,7 @@ static inline unsigned amdgpu_sa_bo_hole_eoffset(struct
amdgpu_sa_manager *sa_ma
  	struct list_head *hole =3D sa_manager-&gt;hole;
    	if (hole-&gt;next !=3D &amp;sa_manager-&gt;olist) {
-		return list_entry(hole-&gt;next, struct amdgpu_sa_bo,
olist)-&gt;soffset;
+		return list_first_entry(hole, struct amdgpu_sa_bo,
olist)-&gt;soffset;
  	}
  	return sa_manager-&gt;size;
  }
diff --git a/drivers/gpu/drm/omapdrm/dss/display.c
b/drivers/gpu/drm/omapdrm/dss/display.c
index 0c9480b..fb9ecae 100644
--- a/drivers/gpu/drm/omapdrm/dss/display.c
+++ b/drivers/gpu/drm/omapdrm/dss/display.c
@@ -158,8 +158,8 @@ struct omap_dss_device *omap_dss_get_next_device(struct
omap_dss_device *from)
  				goto out;
  			}
  -			dssdev =3D list_entry(l-&gt;next, struct omap_dss_device,
-					panel_list);
+			dssdev =3D list_first_entry(l, struct omap_dss_device,
+						  panel_list);
  			omap_dss_get_device(dssdev);
  			goto out;
  		}
diff --git a/drivers/gpu/drm/radeon/radeon_sa.c
b/drivers/gpu/drm/radeon/radeon_sa.c
index 197b157..66c0482 100644
--- a/drivers/gpu/drm/radeon/radeon_sa.c
+++ b/drivers/gpu/drm/radeon/radeon_sa.c
@@ -158,7 +158,7 @@ static void radeon_sa_bo_try_free(struct
radeon_sa_manager *sa_manager)
  	if (sa_manager-&gt;hole-&gt;next =3D=3D &amp;sa_manager-&gt;olist)
  		return;
  -	sa_bo =3D list_entry(sa_manager-&gt;hole-&gt;next, struct radeon_sa_bo,
olist);
+	sa_bo =3D list_first_entry(sa_manager-&gt;hole, struct radeon_sa_bo,
olist);
  	list_for_each_entry_safe_from(sa_bo, tmp, &amp;sa_manager-&gt;olist, oli=
st) {
  		if (sa_bo-&gt;fence =3D=3D NULL ||
!radeon_fence_signaled(sa_bo-&gt;fence)) {
  			return;
@@ -182,7 +182,7 @@ static inline unsigned radeon_sa_bo_hole_eoffset(struct
radeon_sa_manager *sa_ma
  	struct list_head *hole =3D sa_manager-&gt;hole;
    	if (hole-&gt;next !=3D &amp;sa_manager-&gt;olist) {
-		return list_entry(hole-&gt;next, struct radeon_sa_bo,
olist)-&gt;soffset;
+		return list_first_entry(hole, struct radeon_sa_bo,
olist)-&gt;soffset;
  	}
  	return sa_manager-&gt;size;
  }
</pre>
        </blockquote>
        <pre wrap=3D"">
--
You received this message because you are subscribed to the Google Groups
"outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an
email to <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:outreachy-ker=
nel+unsubscribe@googlegroups.com">outreachy-kernel+unsubscribe@googlegroups=
.com</a>.
To post to this group, send email to <a class=3D"moz-txt-link-abbreviated" =
href=3D"mailto:outreachy-kernel@googlegroups.com">outreachy-kernel@googlegr=
oups.com</a>.
To view this discussion on the web visit
<a class=3D"moz-txt-link-freetext" href=3D"https://groups.google.com/d/msgi=
d/outreachy-kernel/8b1e22f8-7a05-b66b-8825-7d4d97e46dac%40amd.com">https://=
groups.google.com/d/msgid/outreachy-kernel/8b1e22f8-7a05-b66b-8825-7d4d97e4=
6dac%40amd.com</a>.
For more options, visit <a class=3D"moz-txt-link-freetext" href=3D"https://=
groups.google.com/d/optout">https://groups.google.com/d/optout</a>.
</pre>
      </blockquote>
      <pre wrap=3D"">&gt;</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
dri-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:dri-devel@lists.freede=
sktop.org">dri-devel@lists.freedesktop.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/dri-devel">https://lists.freedesktop.org/mailman/listinfo/dr=
i-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;outreachy-kernel&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:outreachy-kernel+unsubscribe@googlegroups.com">ou=
treachy-kernel+unsubscribe@googlegroups.com</a>.<br />
To post to this group, send email to <a href=3D"mailto:outreachy-kernel@goo=
glegroups.com">outreachy-kernel@googlegroups.com</a>.<br />
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/outreachy-kernel/dfc1bc65-d6c0-8935-e787-4743d3cdabae%40amd.com?=
utm_medium=3Demail&utm_source=3Dfooter">https://groups.google.com/d/msgid/o=
utreachy-kernel/dfc1bc65-d6c0-8935-e787-4743d3cdabae%40amd.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--------------6CE5DA37F03A48653B7B4E05--
