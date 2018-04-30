Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZrdzUelrTDJLwYlAzxBAFdfTxmQ3SL0464XitUhhuOt0KqxqL76LcNxWV/ZLpbwFYz9mGwZ
ARC-Seal: i=1; a=rsa-sha256; t=1525075636; cv=none;
        d=google.com; s=arc-20160816;
        b=BIZ7/zz+XgGEady+VbNp/+Ja2gVRn7zoU1jXIN5Xt2Kyr/fVXqr7YVjMImpoktONNB
         wi4q6DB0xtswBtLvc/CKEzLcY/PLnYn6gRfzqev4Zp5RPdhnbqBktSV4MSJHACoQFwNN
         lY2RenPqvjZXFhN4h2PXx1G0yiQB8RTLDOCaC4Ka3k4TrIlY9DXlC0zrDUxo13/u8Yv3
         zskQpT26ztlYVYr7YD2tC/PtLhjRTCziGupHb2Bh2YSABe0dBDN1Z+qlXJTJ5t+FF1h4
         nNW2pcODppc6O3jNe0ZzAqM2pmuXCoOPWoTFpKn4M2pJyPy1eGuO7q+7Id9ZkvXU51jJ
         Vqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :dkim-signature:arc-authentication-results;
        bh=uhVhCB3sBXlzHdOkyrbIY2Ta184jkqaU5FtX9tpPImc=;
        b=QZAdPaaXpBHphhrkQ4KfTphARR17iohjAASj9zl0FTELJbQMi0S6kVbQyyOWp7aVzJ
         WfxXsX4tmzWxScnD4wW7s+0TTfrWLBb6Ow1MXxmOLciN2pkBZAzdpbhDWGU/uun381dr
         K742VPA1+VtjmMx2nooMpJiPkuJnftqa1cLCO+KXyLwleHFAXiRLH4fQK1Xbfa/YkF4d
         GFjEoLP5f1XI5J0v57//mZdtFsUFK8AiMMavCHAy/zSHMTjrKBNJRodd3fhFp9axJSMW
         svTV9rmHGigJGsZyFTtNAsd9OgPgFX6dZW7bNoXT4SIyW5Un9WQ4ALcvPuacCHYd7XRN
         KTzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=iNCPAAJv;
       spf=neutral (google.com: 104.47.38.80 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=iNCPAAJv;
       spf=neutral (google.com: 104.47.38.80 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 02/11] ASoC: amd: dma config parameters changes
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
 jclinton@chromium.org, Akshu Agrawal <akshu.agrawal@amd.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-2-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omBgTPJMB0V5s_K8cYtg+koB_-HBdy33kcRCAe4deEK-Gw@mail.gmail.com>
Message-ID: <4ee36e1e-2557-2624-b291-37962f062372@amd.com>
Date: Mon, 30 Apr 2018 13:39:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omBgTPJMB0V5s_K8cYtg+koB_-HBdy33kcRCAe4deEK-Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::21) To CY1PR12MB0310.namprd12.prod.outlook.com
 (2a01:111:e400:50f8::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0310;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0310;3:J9qQUROT1S8ZALlO9cUIxQSjAvrB7G3RgkufHF4u9Emc4eenW/0mhL88Gdg8GxDYxJDkHvsRRmQQpLg/HcwshZ3Gvh9LI0pgECrEH16AAMxW+lhHMrYn0VYp3mE7NYjrSFoKR18JcFCXmt3bn6xnAbp9FqffAbeYzYIavhx6kXqpN3rg0yGlgaLLjo7/90sJiGDV2NUR1lSSOtJITiYKHsu6g9vRR5s8NWg0Ci/DbyAVBeT8RxmduZRwjOiMkXso;25:OW5asMVnIVP6PYCU6acxjjIG+dIjj/CvOX3O8BQQtM13xz9We0Qf5p88vlV+kNzT5MZ4Hz09gD/a9sSFOD6hyNL2lOef4+vjUMxrJ/dpBz8UWvTuCZXkdj4+CSeTHnE9e6e/ez582XfdEbTKxhacnzL1WAtopERujb1z1P9qQenOb+RpHtQ/ZX1zGdFZw/SU+kcg2SE7zcuw2ng8IjlPBZpNKzBIggcQuT/seGJKAeADJnDyfuNOLiuCtEFcnTMwNmZins/7Re2NnkDo7711jIowZLJGXirHCoW1LU+VTaBaRlD+fyNqvDMOUq9rlDbPcUBi6LNHrJOEU8/W6Vfyrg==;31:Y2CpeqI+xXdRe8/7AmjEoEaFN646ltHp6kpgt7dS6r2VUrAyLX/a2rWeCdeDmKy3VthjyRX6+uPVDW6hJ77bBAkOF0KpqOO7cdgQbHCsLxC92xHiCOocb/pSR2TLdoS3YoJXM6wQ1shMisH2iDgE9nNKMGWw4J4NxxaNHaZDuPdrTTGgn2bzVKODuV3lXwLqpQLMU5Yd9Xbj+abnQy8m6qorAtlZXjN3iEa4N4jQ41M=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0310:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0310;20:W7TCGSYV7XLb19rf3Gk9GIS6o52hP9zw2Jtt0cgBQnMH6LXZ9Rd0CZvh/qufTrmWpyjWmDQ7yiqeXKoFIBUz9VV6uO/ywQ6iwZntMZ/DvUmeewGsUwxznZ+5Td2HVWkyO9kGBe2nTA5jXj2fr7Rr35HAnLdykuKCMKlhwiQPpwD/IXGOhAW/FyfLPEaeKc/ZO7ejCh8lMbl94FNiH/etFU0gGTF4quVeuzCCOGcFii/Ltm+NzYR1KWrXuUpm38ri0lPcZpdlQT20lLLxjeyUEHHmZF26MvD8kIevt+AzoYsPzGjhAjQB6SMnfYmRHRPjqj5H29F/+FgZRmmchslC27jkZ8pmlOlUoTeJIQWsyDP/YQ7yztJuNx+E5btGflQePYtieIiCgDUUGQV8H1Z5cTfE1lmc7LTF72cphQeQqVvFL37+OD8sqcrwe9jAvyMQ8EgpPGrWNhPTb6UL6pl27fn0rXJ5RGMI9Spixl5ixgFm2gSO0F79VZXlbpy/07ws;4:o7OJFjM4HItARKtr6iyWY01UR3Lw+T2MmJk+Pba9Q0cvYH0UjzT11FYALKkrjhOmBOKwjYTLQkxsLPVy66GcSNLfXfnWfqloVPE0+79As44p6jpILrychIKTDlqrKVOHQhvDFrPA51O060WYjSUXa+cRcJQf0/ja8GOhDElTA/KmgHL3J3OFVhEmoQlPuedYBjFqky8kKU30mdkL+g4x/1xp8ptY2Gewq3bYGBZClrdK6+thtvSZ+knII3s3QEKMPpZI10FauuVAAJUqGs5mcjAgtS4SW6/osXCNwvXlP+QdbmwF2hfInowsQXag4A7V
X-Microsoft-Antispam-PRVS: <CY1PR12MB03104B0FC1723AE847466DEF97820@CY1PR12MB0310.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0310;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0310;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(396003)(39380400002)(376002)(366004)(199004)(189003)(47776003)(5660300001)(11346002)(52116002)(6666003)(6916009)(4326008)(6246003)(25786009)(39060400002)(31686004)(2906002)(53936002)(81156014)(81166006)(8676002)(7416002)(105586002)(65826007)(65956001)(8936002)(476003)(52146003)(23676004)(2486003)(65806001)(66066001)(68736007)(76176011)(230700001)(106356001)(2616005)(956004)(67846002)(7736002)(77096007)(486006)(64126003)(305945005)(97736004)(26005)(72206003)(446003)(6116002)(59450400001)(3846002)(53546011)(6486002)(478600001)(386003)(16526019)(186003)(86362001)(31696002)(229853002)(58126008)(54906003)(50466002)(316002)(36756003)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0310;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMzEwOzIzOnJiSndRNG94VEl3M20rTXJlR0c5VHByVzQx?=
 =?utf-8?B?cDhXYlZNakVpZkIwNGdzUkduRCtpeEtFRHNVUHNRalFuQTI4SWV2TXdTbGdO?=
 =?utf-8?B?eW1maTl3dXZ5QXhHM3hnNlNTSjkrL08xNG4xTHVqdnN4L1pDdm9pTnFIUmxk?=
 =?utf-8?B?bDRtanJPbFRBeXMvdTNrQVlkU2NGN1ZpcHQzT2E4MHNHUEdFVkxESklsc3ZG?=
 =?utf-8?B?WVUrUkNoTFZsY09SeE4rMDRDMlVlZGh5UTF4SXlmcDVha21EQy9lb0E2YW9y?=
 =?utf-8?B?ZUJVOXltQVlDVCtvWVJsU05xSU5YajVUQmdleXlaVXhrQ1NmUXI1QUg5Znlj?=
 =?utf-8?B?U094UU00M3hwZm5IeU9xS3V3SkJvK3doL2F6amp1OVdGa3kzOFpkaXlLWitD?=
 =?utf-8?B?ZEFmQVJlRGVBUmZrdkN5VWQzLzdKTDZTdFEyMXExUmpoOUtheXdUckMrQisw?=
 =?utf-8?B?eUVzRXJyNkNTN3ZzNG9ETUZDc3VDNG5pRkZsZWJ0YUQxd0tZejlualNnSTVx?=
 =?utf-8?B?K2dsU3ZheENNeVRvSmhvSHNQYUhvN2QzeXFka2tzYWo1U0F2WitXQjU2OWdm?=
 =?utf-8?B?Y2xmWThVVGc1YzFjL055TktTSFJLSDQrdkFQRjJvWkhzblB3YjdYV3ZKZmxC?=
 =?utf-8?B?MkJYWHE4VVd4ak5KcEdSbjZVUTJCank0d1kzRitZZmNLQmFWZXM3TldCZjVC?=
 =?utf-8?B?aGs1UDB0NEdMNDBINkFkdkgvUklJOHdjSm1ISXlBNzc5TmdKYnV3N2VQTGd5?=
 =?utf-8?B?eFhJZ21KNDUwNnp6WWFYMzlabnpUcTg4S2lXZHpaNzdHMERNVmdQRFpnOW1T?=
 =?utf-8?B?anhyUmV2cmJjVGo3QmtlTEVhY3lsYnhaK2drQ0VwTW9ZTlQ2cUJla01Xcldr?=
 =?utf-8?B?aURjOXdMSWgvY094OHdMekVCQWFLMnFZMmFkQUE5bDljRFFpWkJDYnMwem4r?=
 =?utf-8?B?Vkk0eElTQlpRU1JyckFkRGVPNG9tRDhJVGVIOUxDeUtEcktpTE5SZCsyVmJX?=
 =?utf-8?B?V2EvZUMydjVJM3VsYlZOWmFOTUp1TVZnNjA1SVpYTXY3eDVqc29MQ3lJVTl1?=
 =?utf-8?B?K2t3R1BocXlJaWxCZG42WUsrb2pERml6TFh3cVBSakJ3M0lrN3V0TDdTdG9Z?=
 =?utf-8?B?U1Z3WndGeDhQL3hRS2lqeUZsTUpiQ3ZqOVJtdXFYK3M1b3BnYlNiK1l5U1gz?=
 =?utf-8?B?ZzkzSENJdzJPanpXT2xpYnZBZU16U2pIKytqQTV0SkxUdk9HMTBkaVBVa0Rm?=
 =?utf-8?B?bEV4UFByTEk1dFRoMVlsYU5uMjRWVklRa3pQa1V3QlE3WXF1eUNzSitwU0Nv?=
 =?utf-8?B?RXMwekljT3VQeHhBUlFUdUFXRmh2N1YyUldYbTBSblM3K2IzWUFHb0lRZVRZ?=
 =?utf-8?B?OGJwV2xDcVlueDBRZ2RZbmxTcGVOQzlqQzJ6dnFJZXRWSGZBM2NLOFVMVVZ3?=
 =?utf-8?B?cDFyMEdaVVdBN0JLV2E1RG5BVk95Vy8waXJMSVpwSEtvaVNIMGEvOUYyNlF5?=
 =?utf-8?B?TU9ZcVdWSUdzajU1SmR1cmJ6bDY4RFJ5SWtYUnpTTDlrazB5b3MwYjU2ZjJo?=
 =?utf-8?B?aWwyODFXNFZEeDhpZjVMSklVZUlYZ1RZNEExMGpTV0pHMzNpSlVpSFExZ09m?=
 =?utf-8?B?dUZqa2I5WGU1dkpia0syZWFNVmNQazdpaUhKUm82QTBiMWZML2NNSkVzNk9Z?=
 =?utf-8?B?RGJkZTUzbjF5ZTNrWHpOa1F6RUZjeWVpRitSNG5RQ2tKRkVOa2FhQjZ1bHVp?=
 =?utf-8?B?ZDBadDBmMGk5MG96TXR5Z0wzdTBPRnFkRHJjaGVPbGZzaVY1TGhPUTgzOWh1?=
 =?utf-8?B?VFBvZ3Fza3JOV2laRmtqWnUwd2FSUk10R2w2TkpwOTNHNnNoUW93dllPZGpL?=
 =?utf-8?B?Q2dlTmFaZmh4U1lrYUtpdnZqYjlHcllDYjhlcFF5VHc1S3lIZkNCbHlERUZS?=
 =?utf-8?B?R3dNcklPcmE3YW9HWVExeHRodE9QdStYcWZnK0JUSVRZOTAwSVA4Y1NzM1Jv?=
 =?utf-8?B?R0E3U0t4ZHlMTFFEeFBSR3NwRlY0NEFzYkFSOWhhNVlhWVNLZmUzOVFKcWsy?=
 =?utf-8?B?dk1yRHQzdFI3QTlsK3MrT3RnZk5QRXQxYUgyZ2puWm1TYWQvMnBjZk9RaHJs?=
 =?utf-8?B?K3c9PQ==?=
X-Microsoft-Antispam-Message-Info: H/SfmM/tGGgqukr45bnikfuggehfI5n/BelUHCz3UN1rqVfrfJzbxod1lp2uDN8lsyNhTIX/1XJiNCfBj25H3d1UnYAunuH+c85hJY3j36o0Cjx5Dgj9w/WXzqohD44QM8hcPrg38vYf7M+pjdUdj5+IQFFgpIxDjlmWfqmKzTjxP097luLlL17RG+jixQXI
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0310;6:6mUdWfeXtns/SD4OiyGhfX4+1AonR2EcjPYpjk0hab7i4ObRlx1L0mbSNTVuAY2EYWb+ZeZI3uIXVVe58g7EuGKjtE376492kmHGn0q8ozQKSqJzqqF//ufRG9+hssGMVO+sx874xuiXB+fAMdkomS6Jk3pGLD6CSQIXM+d2z/HVIi0+NglgxEjIod5+2vlsgc0qutNv1hnI1DSt0wPorFdzzbRqwYYhSDb7wnYwxjiAdQRrqMQQxzdRyzc9/zepBAu8j7GeH2BfrtjbLqFl6mDUo9G4nvRJ8t5Ug++sEyljAsmxzWeEURCnqJCd8LcV68RoJ80S5V39TzU5m+QhLvIFvyTZPbuQeOrYC2/pzfx0hq/2hQSw42HpJd+X/bcSlGhEG4i8fcSlzLoS43ctO6MHBgaw4KTlhXdRlp/U3OByNxz80WoATt+q3M+RsJmMPcAPU7o3vZMZcw2UXvQxCw==;5:RVP2GSHbBvwEM11geQywn2sUES2807qHc9nzye0F7gz3qRh/jmefUIAtguN2/8fpjnlGFJw0y2ggHgAWoprI71zTQT8xa3A5ksFARlGZAwvU14r0PxV5RBJcGVXCBfrbnQe1bv633t9fOJzlIdLSrMB47cNr3yBRcH3H/U3A14s=;24:5QcTM8zVDXxB/M20D3USZGyocX4c9Sc9mmBvYX3O3bbhrkyq4f2qQ/J4oD1SgYw6bSTpfPQkjPtc1c2pKsgKZVUoaJoHhAmHf5zCOxrWc1E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0310;7:eDLaYWWq2AXIDSDyKQKV6bkvOd28OUR3GpXE2osLBJeHG+IiyxlBPjv2wY3ItcfHqpZEelJbQXAJKwJtCa/umlNss5Ez/KEAV5PgzEhwBL5aGkZVnLu9/bBuAyRsdtycvC59/XbX02uU4FaqDQsR7wjl7d/7qQtQ1+8Og4iIkdxibkGmNOeRz/5L4DUsy6p+rSnIfgoizLsj/OKFCv4X3S/doBCma16qZsTUPUzsHXqwYOpTGWsXQphWfq7szFRk;20:AgcPdU5pyk6C95G0SN1QEh9MblTOnL9UewH2TtVsPSGWz5uRUiR56abRkqhUynj7Rw0LP9TCCGOsDO/IUEGf0VsnTC8jv4OhFA+E7oxtwUWhOzZblVnFktVAsmY4irybC8YmHSahAjsVzQQIkTuESpfniMwcAbNI9OOzxAPYdqypuBVGSKfsLKXSFB5WKUZS8FEGsv/7mevo7naE4iMSShGRg75Z+nbogJgeU10VVhtuLkvnBmOk5o3BpSr6RF7Z
X-MS-Office365-Filtering-Correlation-Id: a7018dde-5faf-4f37-ef57-08d5ae7160e1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 08:07:08.8375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7018dde-5faf-4f37-ef57-08d5ae7160e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0310
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807079775772304?=
X-GMAIL-MSGID: =?utf-8?q?1599157711086277008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Monday 30 April 2018 03:19 AM, Daniel Kurtz wrote:
> Hi Vijendar,
> 
> On Thu, Apr 26, 2018 at 5:14 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> Added dma configuration parameters to rtd structure.
>> Moved dma configuration parameters intialization to
>> hw_params callback.
>> Removed hard coding in prepare and trigger callbacks.
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>     sound/soc/amd/acp-pcm-dma.c | 97
> +++++++++++++++++----------------------------
>>     sound/soc/amd/acp.h         |  5 +++
>>     2 files changed, 41 insertions(+), 61 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index 9c026c4..f18ed9a 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -321,19 +321,12 @@ static void config_acp_dma(void __iomem *acp_mmio,
>>                               u32 asic_type)
>>     {
>>            u32 pte_offset, sram_bank;
>> -       u16 ch1, ch2, destination, dma_dscr_idx;
> 
>>            if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
>>                    pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
>> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;
>>                    sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
>> -               destination = TO_ACP_I2S_1;
>> -
>>            } else {
>>                    pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
>> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;
> 
> Wait... since this is the capture stream, shouldn't the channels have been:
> 
>      ch1 = ACP_TO_SYSRAM_CH_NUM; /* 14 */
>      ch2 = I2S_TO_ACP_DMA_CH_NUM; /* 15 */
> 
> Is this an existing bug?  Why does everything still work if these are wrong?
You are correct. We Will fix it and share fresh patch.
> 
>>                    switch (asic_type) {
>>                    case CHIP_STONEY:
>>                            sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
>> @@ -341,30 +334,19 @@ static void config_acp_dma(void __iomem *acp_mmio,
>>                    default:
>>                            sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
>>                    }
>> -               destination = FROM_ACP_I2S_1;
>>            }
>> -
>>            acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
>>                           pte_offset);
>> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
>> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
>> -       else
>> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
>> -
>>            /* Configure System memory <-> ACP SRAM DMA descriptors */
>>            set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
>> -                                      rtd->direction, pte_offset, ch1,
>> -                                      sram_bank, dma_dscr_idx,
> asic_type);
>> -
>> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
>> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
>> -       else
>> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
>> +                                      rtd->direction, pte_offset,
>> +                                      rtd->ch1, sram_bank,
>> +                                      rtd->dma_dscr_idx_1, asic_type);
>>            /* Configure ACP SRAM <-> I2S DMA descriptors */
>>            set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
>>                                           rtd->direction, sram_bank,
>> -                                      destination, ch2, dma_dscr_idx,
>> -                                      asic_type);
>> +                                      rtd->destination, rtd->ch2,
>> +                                      rtd->dma_dscr_idx_2, asic_type);
>>     }
> 
>>     /* Start a given DMA channel transfer */
>> @@ -804,6 +786,21 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>                    acp_reg_write(val, adata->acp_mmio,
>>                                  mmACP_I2S_16BIT_RESOLUTION_EN);
>>            }
>> +
>> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> +               rtd->destination = TO_ACP_I2S_1;
>> +               rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
>> +               rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
>> +       } else {
>> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> +               rtd->destination = FROM_ACP_I2S_1;
>> +               rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
>> +               rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
>> +       }
>> +
> 
> I think you should do this initialization in acp_dma_open(), where the
> audio_substream_data is kzalloc'ed and otherwise initialized to match the
> provided snd_pcm_substream.

The idea to move initialization from acp_dma_open() to 
acp_dma_hw_params() callback is to exchange platform data between 
machine driver and dma driver.
So that during initialization we can use data from machine driver and do
platform specific initialization where and when required.
In Current scenario, by the time new stream open call invoked, dma 
driver is not aware of which i2s_instance sub stream refers to .
We have added logic in machine driver to pass I2S instance information 
as sound card private data in subsequent patch.
We implemented logic to set the I2S Instance value in Codec startup 
api's in machine driver.
If we do initialization in dma driver open call , its not possible to 
extend the idea of switching between two i2s instances.

> 
>>            size = params_buffer_bytes(params);
>>            status = snd_pcm_lib_malloc_pages(substream, size);
>>            if (status < 0)
>> @@ -898,21 +895,15 @@ static int acp_dma_prepare(struct snd_pcm_substream
> *substream)
> 
>>            if (!rtd)
>>                    return -EINVAL;
>> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               config_acp_dma_channel(rtd->acp_mmio,
> SYSRAM_TO_ACP_CH_NUM,
>> -                                      PLAYBACK_START_DMA_DESCR_CH12,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -               config_acp_dma_channel(rtd->acp_mmio,
> ACP_TO_I2S_DMA_CH_NUM,
>> -                                      PLAYBACK_START_DMA_DESCR_CH13,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -       } else {
>> -               config_acp_dma_channel(rtd->acp_mmio,
> ACP_TO_SYSRAM_CH_NUM,
>> -                                      CAPTURE_START_DMA_DESCR_CH14,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -               config_acp_dma_channel(rtd->acp_mmio,
> I2S_TO_ACP_DMA_CH_NUM,
>> -                                      CAPTURE_START_DMA_DESCR_CH15,
>> -                                      NUM_DSCRS_PER_CHANNEL, 0);
>> -       }
>> +
>> +       config_acp_dma_channel(rtd->acp_mmio,
>> +                              rtd->ch1,
>> +                              rtd->dma_dscr_idx_1,
>> +                              NUM_DSCRS_PER_CHANNEL, 0);
>> +       config_acp_dma_channel(rtd->acp_mmio,
>> +                              rtd->ch2,
> 
> The original code was using ACP_TO_SYSRAM_CH_NUM for the capture case, but
> now you are using SYSRAM_TO_ACP_CH_NUM as just initialized in
> acp_dma_hw_params().  I think the old config_acp_dma() was wrong, and it
> should still be ACP_TO_SYSRAM_CH_NUM.  When you make this fix, either do it
> in a separate preliminary patch (preferred), or at least call it out in the
> commit message.
> 

You are correct. We will fix it and will post fresh patch.

> Also, instead of "ch1" and "ch2", perhaps we can use the more descriptive
> "ch_i2s" and "ch_sysram" [and same for dma_descr].
If we change ch1, ch2 channels naming convention , it will be quite 
confusing in rest of code.
playback use case ch1 refers to sysram to acp and ch2 refers to acp to 
i2s fifo where as for capture ch1 refers to acp to sysram and ch2 refers
to i2s to acp.
Rather than we will add comment what ch1, ch2 refers to improve readability.
same applies for dma descriptor idx also.
> 
>> +                              rtd->dma_dscr_idx_2,
>> +                              NUM_DSCRS_PER_CHANNEL, 0);
>>            return 0;
>>     }
> 
>> @@ -939,10 +930,9 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>                    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>>                            if (rtd->i2ssp_renderbytescount == 0)
>>                                    rtd->i2ssp_renderbytescount = bytescount;
>> -                       acp_dma_start(rtd->acp_mmio,
>> -                                     SYSRAM_TO_ACP_CH_NUM, false);
>> +                       acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
>>                            while (acp_reg_read(rtd->acp_mmio,
> mmACP_DMA_CH_STS) &
>> -
> BIT(SYSRAM_TO_ACP_CH_NUM)) {
>> +                               BIT(rtd->ch1)) {
>>                                    if (!loops--) {
>>                                            dev_err(component->dev,
>>                                                    "acp dma start
> timeout\n");
>> @@ -950,38 +940,23 @@ static int acp_dma_trigger(struct snd_pcm_substream
> *substream, int cmd)
>>                                    }
>>                                    cpu_relax();
>>                            }
>> -
>> -                       acp_dma_start(rtd->acp_mmio,
>> -                                     ACP_TO_I2S_DMA_CH_NUM, true);
>> -
>>                    } else {
>>                            if (rtd->i2ssp_capturebytescount == 0)
>>                                    rtd->i2ssp_capturebytescount =
> bytescount;
>> -                       acp_dma_start(rtd->acp_mmio,
>> -                                     I2S_TO_ACP_DMA_CH_NUM, true);
>>                    }
>> +               acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
>>                    ret = 0;
>>                    break;
>>            case SNDRV_PCM_TRIGGER_STOP:
>>            case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>            case SNDRV_PCM_TRIGGER_SUSPEND:
>> -               /*
>> -                * Need to stop only circular DMA channels :
>> -                * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM.
> Non-circular
>> -                * channels will stopped automatically after its transfer
>> -                * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
>> -                */
>>                    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          SYSRAM_TO_ACP_CH_NUM);
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          ACP_TO_I2S_DMA_CH_NUM);
>> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>> +                       ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>>                            rtd->i2ssp_renderbytescount = 0;
>>                    } else {
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          I2S_TO_ACP_DMA_CH_NUM);
>> -                       ret = acp_dma_stop(rtd->acp_mmio,
>> -                                          ACP_TO_SYSRAM_CH_NUM);
>> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>> +                       ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
> 
> Using "ch_i2s" and "ch_sysram" would help here, since then it wouldn't need
> to do the slightly confusing "stop 2 then stop 1".

same comments apply as mentioned in above review comment.
> 
> -Dan
> 
> 
>>                            rtd->i2ssp_capturebytescount = 0;
>>                    }
>>                    break;
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 0e6089b..5e25428 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -85,6 +85,11 @@ struct audio_substream_data {
>>            unsigned int order;
>>            u16 num_of_pages;
>>            u16 direction;
>> +       u16 ch1;
>> +       u16 ch2;
>> +       u16 destination;
>> +       u16 dma_dscr_idx_1;
>> +       u16 dma_dscr_idx_2;
>>            uint64_t size;
>>            u64 i2ssp_renderbytescount;
>>            u64 i2ssp_capturebytescount;
>> --
>> 2.7.4
